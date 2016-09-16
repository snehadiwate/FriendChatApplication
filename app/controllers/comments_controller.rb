class CommentsController < ApplicationController
   before_action :set_post, only: [:show, :edit, :update, :destroy]
   
  def edit
  end
  
  def create
     @comment = Comment.new(comment_params) 
     respond_to do |format|
       if @comment.save
         format.json { render :json => user_post_comment(@comment), :success => "success", :status_code => "200"}
       end
    end
  end
  
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to :controller => 'home', :action => 'index' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
   private
   
    def set_post
      @comment = Comment.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id,:post_id)
    end
    
    def user_post_comment(comment)
       {content: comment.content, user_name: comment.user.full_name, post_id: comment.post_id}
    end
end
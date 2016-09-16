class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user  = User.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
       current_user.friends.each do |user|
         UserMailer.send_for_notification(@post, user.email).deliver!
       end
        format.html { redirect_to  :controller => 'home', :action => 'index' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to :controller => 'home', :action => 'index' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_comment
    if current_user
 
      @post = Post.find(params[:post][:post_id])
      @comment= current_user.comments.new(:post_id => @post.id, :content => params[:post][:comment])
      if @comment.save
        render :json =>{:user => current_user.full_name, :comment => @comment }
      else
        @comment_error = '<div class="alert alert-warning alert-dismissible text-center" id="error_box" role="alert">
                      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                      <strong>'+@comment.errors.messages+'</strong>
                       </div>'
        render :json => {:comment_error => @comment_error} ,:status => :unprocessable_entity
      end
    else
      @comment_error = '<div class="alert alert-warning alert-dismissible text-center" id="error_box" role="alert">
                      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                      <strong>Please login first before comment on any post</strong>
                       </div>'
      render :json => {:comment_error => @comment_error} ,:status => :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
     local_params =  params.require(:post).permit(:post_text, :user_id, :visible,:post_title, :upload)



      local_params.merge! user_id: current_user.id

      local_params
    end
end

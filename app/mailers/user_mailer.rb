class UserMailer < ApplicationMailer

  def send_for_notification(post_object, user)
   @post = post_object
   mail = user
   @url = 'http://localhost:3000'
   mail(to: mail, subject: 'New Post added')
  end
end

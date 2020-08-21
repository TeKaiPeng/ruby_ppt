class PostMailer < ApplicationMailer
  def poster
    @post = params[:post]
    mail to: @post.user.email, 
      subjext: "新增文張：#{@post.title}"
  
  end
end
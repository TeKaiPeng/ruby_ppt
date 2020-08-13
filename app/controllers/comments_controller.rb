class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create  #使用者登入的情況下，要新增留言
    @post = Post.find(params[:post_id]) #先找到是哪篇文章
    @comment = @post.comments.new(comment_params) #定義comment並且新增留言
    if @comment.save
      redirect_to @post
    else    
      redirect_to @post
    end

  end

  private
  def comment_params #一樣要清洗他輸入的東西，還有是誰寫的
    params.require(:comment).permit(:content).merge(user: current_user) 
  end

end

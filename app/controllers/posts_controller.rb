class PostsController < ApplicationController
    before_action :find_board, only: [:create, :new]
    # before_action :authenticate_user!, except: [:show] #除了show以外，都需要使用者登入

    def new
        @post = @board.posts.new
        # @post = Post.new
        # 因為重複動作不用把一個實體變數指定成兩個東西
    end

    def create
        # @post = current_user.posts.new(post_params)
        # @post.board = @board

        @post = @board.posts.new(post_params)
        # @post.user = current_user    #下面private有寫入，這邊就可以省略

        if @post.save
            redirect_to @board, notice: '文章新增成功'
        else
            render :new
        end
    end

    def index
    end

    def edit
        # @post = Post.find_by[id: params[:id], user: current_user]
        @post = current_user.posts.find(params[:id])
    end
    
    def update
        @post = current_user.posts.find(params[:id])
        
        if @post.update(post_params)
            redirect_to @post, notice: '文章更新成功'
        else
            render :edit
        end
    end


    def show 
        @post = Post.find(params[:id]) #先找到那篇文張
        @comment = @post.comments.new
        @comments = @post.comments.order(id: :desc) #因為這邊的表單會有很多留言，所以要用複數 .order後面就是他的順序，desc等於反過來把最新的放在上面
    end    

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to board_path(@post.board), notice: "刪除成功啦"
    end

    private
    def post_params
        params.require(:post)
            .permit(:title, :content)
            .merge(user_id: current_user.id) #讓上面的post_params抓到user，merge後面有沒有驚嘆號都可以，無論有沒有改變，這邊只要回傳結果
    end

    def find_board
        @board = Board.find(params[:board_id])
    end
end

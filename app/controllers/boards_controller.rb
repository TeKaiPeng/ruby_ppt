class BoardsController < ApplicationController
    include UsersHelper

    before_action :find_board, only: [:favorite, :show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]


    def index
        @boards = Board.where(deleted_at: nil)
    end
    
    def show
        @post = @board.posts.includes(:user)

    end

    def favorite
        current_user.toggle_favorite(@board) #先定義toggle在model，之後取用比較方便

        respond_to do |format| 
            format.html {redirect_to favorites_path, notice: 'OK!!!'} #如果來的是HTML的話，去最愛頁面
            format.json {render json: {status: @board.favorited_by?(current_user) } } #如果來的是json 給他狀態1
        end 
    end


    def new
        # if user_signed_in? #!上面有before_action了所以可以註解掉
        @board = Board.new
        # else
        #     redirect_to root_path, :notice '請先登入'
        # end
    end

    def create
        @board = Board.new(board_params)

        if @board.save
            redirect_to boards_path, notice: "新增成功"
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @board.update(board_params)
            redirect_to boards_path, notice: "更新成功"
        else
            render :edit
        end
    end

    def destroy
        @board.destroy
        redirect_to boards_path, notice: "刪除成功啦"
    end


    private
    def find_board
        @board = Board.find(params[:id])
    end

    def board_params
    params.require(:board).permit(:title, :intro)
    end


end

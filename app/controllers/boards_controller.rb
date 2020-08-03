class BoardsController < ApplicationController
    include UsersHelper

    before_action :find_board, only: [:show, :edit, :update, :destroy]
    before_action :require_user_sign_in, except: [:index, :show]


    def index
        @boards = Board.where(deleted_at: nil)
    end
    
    def show
        @post = @board.posts
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

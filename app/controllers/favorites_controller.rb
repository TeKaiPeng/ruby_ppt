class FavoritesController < ApplicationController

# before_action :authenticate_user! #需要登入才看得到

    def index
        if current_user
            @boards = current_user.favorited_boards #目前的已經登入的使用者，有多個喜歡的看板
        else
            redirect_to sign_up_users_path , notice: '請先註冊啦！'
        end
    end

end

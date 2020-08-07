class FavoritesController < ApplicationController

beofore_action :authenticate_user! #需要登入才看得到

    def index
        @boards = current_user.favorited_boards #目前的已經登入的使用者，有多個喜歡的看板
    end

end

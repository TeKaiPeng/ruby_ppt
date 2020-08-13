class ApplicationController < ActionController::Base
    # rescue_from ActiveRecord::RecordNotFound, with: :not_found

    before_action :find_user
    helper_method :user_signed_in?, :current_user

    private
    def find_user
        if session[:user_token]
        @current_user = User.find(session[:user_token])
        end
    end

    def not_found
        render file: '/public/404.html', 
                status: 404
                # layout: false
    end

    def user_signed_in?
        # session[:user_token]
        current_user != nil
    end

    def current_user
        # User.find(session[:user_token]) if user_signed_in?
        @current_user ||= User.find_by(id: session[:user_token]) 
        #這個實體變數當下如果有就原User繼續，如果沒有，就根據後面的(id: session[:user_token])去找到那個User實體變數
    end

    def authenticate_user!
        # redirect_to root_path, notice:'請登入會員' if not user_signed_in? //可以縮寫成這樣
        if not user_signed_in?
            redirect_to root_path, notice:'請登入會員'
        end
    end
end

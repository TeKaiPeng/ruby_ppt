class UsersController < ApplicationController
    def sign_up
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            #登入 
            sign_in_user(@user)
            # session[:user_token] = @user.id
            #去首頁
            redirect_to root_path, notice: '會員註冊成功'
        else
            render :sign_up
        end

    end

    def sign_out
        session[:user_token] = nil
        redirect_to root_path, notice: '登出囉！！！'
    end


    private
    def sign_in_user(u)
        session[:user_token] = u.id
    end

    def sign_out_user
        session[:user_token] = nil
    end

    def user_params
        params.require(:user).permit(:account, :password, :email)

    end
    
end

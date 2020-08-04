class UsersController < ApplicationController

    def sign_in
        @user = User.new
    end

    def sign_up
        @user = User.new
    end
     
    def login
        # if user_params[:account] && user_params[:password] #認證過了、就可以省略！
            #認證
            user = User.login(user_params)
            if user
                sign_in_user(user)
                redirect_to root_path, notice: '成功登入囉！！！'
            else
                redirect_to sign_in_users_path, notice: '請輸入正確帳號密碼'
            end
        # else
        #     redirect_to sign_in_users_path, notice: '請輸入正確帳號密碼'
        # end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            #登入 
            sign_in_user(@user)
            # session[:user_token] = @user.id #去首頁
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

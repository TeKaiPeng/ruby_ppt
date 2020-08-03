class User < ApplicationRecord
    validates :account, uniqueness: true, uniqueness: true
    validates :email, uniqueness: true, uniqueness: true


    before_create :encrypt_password

    def self.login(options)
        if options[:account] && options[:password]
            find_by(account: options[:account], 
                    # password: Digest::SHA1.hexdigest('x' + options[:password] + 'y'))
                    password: Digest::SHA1.hexdigest("x#{options[:password]}y"))
        else
            return false
        end
    end


    private 
    def encrypy_password
        self.password = bigbang(self.password)  #self可以拿掉，前面的會變區域變數，後面會變方法
    end

    def bigbang(string)
        # string = 'x' + string + 'y' 晏慈很潮！
        string = "x#{string}y"
        Digest::SHA1.hexdigest(string)
    end


end

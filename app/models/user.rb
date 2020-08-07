class User < ApplicationRecord
    before_create :encrypy_password

    validates :account, uniqueness: true, uniqueness: true
    validates :email, uniqueness: true, uniqueness: true

    has_many :board_masters
    has_many :boards, through: :board_masters
    has_many :posts

    has_many :favorite_boards
    has_many :favorited_boards, through: :favorite_boards, source: :board

    def self.login(options)
        if options[:account] && options[:password]
            find_by(account: options[:account], 
                    # password: Digest::SHA1.hexdigest('x' + options[:password] + 'y'))
                    password: Digest::SHA1.hexdigest("x#{options[:password]}y"))
        # else
        #     return false 因為都是回傳nil, 所以可以乾脆不寫
        end
    end

    def toggle_favorite(b)
        if favorited_boards.exists?(b.id) #先檢查現有的這個id有沒有存在
            favorited_boards.destroy(b)
        else
            favorited_boards << b
        end
    end

    def display_name
        account || '未知'
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

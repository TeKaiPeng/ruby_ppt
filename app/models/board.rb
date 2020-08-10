class Board < ApplicationRecord
    acts_as_paranoid

    has_many :posts
    has_many :board_masters
    has_many :users, through: :board_masters

    has_many :favorite_boards
    has_many :favorited_users, through: :favorite_boards ,source: :user

    validates :title, :intro, presence: true

    def favorited_by?(u)
        favorited_users.include?(u) #這個陣列有沒有包括u這個使用者？
    end

end


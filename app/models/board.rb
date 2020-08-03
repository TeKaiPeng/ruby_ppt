class Board < ApplicationRecord
    acts_as_paranoid

    has_many :posts
    has_many :board_masters
    has_many :users, through: :board_masters

    validates :title, :intro, presence: true

end


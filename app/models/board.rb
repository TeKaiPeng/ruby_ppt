class Board < ApplicationRecord
    acts_as_paranoid
    paginates_per 5
    # default_scope { normal }

    has_many :posts
    has_many :board_masters
    has_many :users, through: :board_masters
    has_many :favorite_boards
    has_many :favorited_users, through: :favorite_boards ,source: :user

    validates :title, :intro, presence: true

    def favorited_by?(u)
        favorited_users.include?(u) #這個陣列有沒有包括u這個使用者？
    end

    include AASM

    aasm(colum: 'state') do # default column: aasm_state
        state :normal, initial: true
        state :hidden, :locked
    
        event :hide do
            transitions from: [:normal, :locked], to: :hidden
        end

        event :show do
            transitions from: :hidden, to: :locked
        end
    
        event :lock do
            transitions from: [:normal, :hidden], to: :locked

            # after_transaction do
            #     puts "以鎖版了！"
            # end
        end

        event :unlock do 
            transitions from: :locked, to: :hidden
        end

      end
    

end


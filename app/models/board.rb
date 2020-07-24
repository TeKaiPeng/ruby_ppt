class Board < ApplicationRecord
    validates :title, :intro, presence: true
    
    def destroy
        update(deleted_at: Time.now)
    end
end


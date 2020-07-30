class Post < ApplicationRecord
  belongs_to :board
  validates :title, presence: true,  :length => {:minimum => 2, :maximum => 5}

  

end

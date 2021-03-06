class Post < ApplicationRecord
  has_rich_text :hello
  belongs_to :board
  belongs_to :user
  has_many :comments
  #has_many :favorite_board

  has_one_attached :photo

  validates :title, presence: true,  :length => {:minimum => 2, :maximum => 10}
  validates :serial, uniqueness: true
  
  before_create :create_serial
  
  def display_username
    # user.nil? ? "沒有填寫" : user.account 底下那一坨可以縮成醬
    if  user.nil? 
      "沒有填寫" 
    else
       user.account
    end
  end

  private
  def create_serial
    self.serial = serial_generator(10)
  end

  def serial_generator(n)
    [*'a'..'z', *'A'..'Z', *0..9].sample(n).join
  end
end

class Post < ApplicationRecord
  belongs_to :board
  belongs_to :user

  validates :title, presence: true,  :length => {:minimum => 2, :maximum => 10}
  validates :serial, uniqueness: true
  
  before_save :create_serial
  
  def display_username
    user.nil? "未知" :user.account
  end

  private
  def create_serial
    self.serial = serial_generator(10)
  end

  def serial_generator(n)
    [*'a'..'z', *'A'..'Z', *0..9].sample(n).join
  end
end

class AddUserToPost < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user 
    #把user_id加入post
  end
end

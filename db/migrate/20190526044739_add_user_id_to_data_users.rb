class AddUserIdToDataUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :data_users, :user, foreign_key: true
  end
end

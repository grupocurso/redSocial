class AddPictureToDataUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :data_users, :picture, :string
  end
end

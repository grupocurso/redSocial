class CreateDataUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :data_users do |t|
      t.string :nick
      t.string :information

      t.timestamps
    end
  end
end

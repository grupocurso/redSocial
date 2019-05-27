class CreateFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fields do |t|
      t.string :lenguage
      t.string :token
      t.string :description

      t.timestamps
    end
  end
end

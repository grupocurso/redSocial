class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.string :description
      t.integer :like
      t.integer :view

      t.timestamps
    end
  end
end

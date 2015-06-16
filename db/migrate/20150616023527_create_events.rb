class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.text :description
      t.decimal :price
      t.string :link
      t.string :sponsor

      t.timestamps null: false
    end
  end
end

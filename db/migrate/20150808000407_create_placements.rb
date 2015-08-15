class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.references :video, index: true, foreign_key: true
      t.references :page, index: true, foreign_key: true
      t.integer :option
      t.text :description
      t.string :title

      t.timestamps null: false
    end
  end
end

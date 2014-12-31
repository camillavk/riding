class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :day
      t.string :area
      t.string :level
      t.string :plan
      t.integer :space
      t.time :meeting

      t.timestamps null: false
    end
  end
end

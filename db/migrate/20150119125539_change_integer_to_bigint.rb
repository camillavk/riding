class ChangeIntegerToBigint < ActiveRecord::Migration
  def change
    change_column :users, :number, :integer, :limit => 8
  end
end

class ChangeChoiceName < ActiveRecord::Migration
  def change
      rename_column :users, :type, :choice
  end
end

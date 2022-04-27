class FixFirstNameColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :fisrt_name, :first_name
  end
end

class FixFirstNameColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :firrt_name, :first_name
  end
end

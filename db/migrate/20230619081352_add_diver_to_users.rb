class AddDiverToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :diver, :string
  end
end

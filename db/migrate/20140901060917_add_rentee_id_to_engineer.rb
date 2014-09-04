class AddRenteeIdToEngineer < ActiveRecord::Migration
  def change
    add_column :engineers, :rentee_id, :integer
  end
end

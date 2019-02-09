class AddUsersIdToIdentifications < ActiveRecord::Migration
  def change
    add_column :identifications, :user_id, :integer
  end
end

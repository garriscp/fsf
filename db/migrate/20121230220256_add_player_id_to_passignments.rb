class AddPlayerIdToPassignments < ActiveRecord::Migration
  def change
    add_column :passignments, :player_id, :integer

  end
end

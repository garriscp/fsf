class AddTeamIdToPassignments < ActiveRecord::Migration
  def change
    add_column :passignments, :team_id, :integer

  end
end

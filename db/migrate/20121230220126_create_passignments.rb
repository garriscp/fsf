class CreatePassignments < ActiveRecord::Migration
  def change
    create_table :passignments do |t|

      t.timestamps
    end
  end
end

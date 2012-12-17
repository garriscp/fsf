class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.string :content
      t.string :source

      t.timestamps
    end
  end
end

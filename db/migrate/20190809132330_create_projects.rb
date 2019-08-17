class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :location
      t.timestamp :last_modified
      t.integer :created_by_id

      
    end
  end
end

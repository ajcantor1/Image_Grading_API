class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :name
      t.string :location
      t.timestamp :uploaded_on
      t.references :project, foreign_key: true
      t.timestamps
    end
  end
end

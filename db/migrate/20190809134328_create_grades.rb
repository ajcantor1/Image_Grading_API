class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.string :location
      t.timestamp :modified_on
      t.references :user, foreign_key: true
      t.references :image, foreign_key: true

      t.timestamps
    end
  end
end

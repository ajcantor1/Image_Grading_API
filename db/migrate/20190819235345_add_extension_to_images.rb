class AddExtensionToImages < ActiveRecord::Migration[5.2]
  def change
  	add_column :images, :extension, :string
  end
end

class AddSlugToModels < ActiveRecord::Migration
  def change
    add_column :models, :slug, :text
    add_index :models, :slug, unique: true
  end
end

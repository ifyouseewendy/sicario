class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.text :name
      t.text :model_slug
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

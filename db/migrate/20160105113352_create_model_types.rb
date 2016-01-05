class CreateModelTypes < ActiveRecord::Migration
  def change
    create_table :model_types do |t|
      t.text :name
      t.text :model_type_slug
      t.text :model_type_code
      t.integer :base_price
      t.references :model, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

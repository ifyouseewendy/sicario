class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.text :name
      t.text :public_name
      t.text :type
      t.text :pricing_policy

      t.timestamps null: false
    end
  end
end

class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.text :required_appliances
      t.text :ingredient_list
      t.text :instructions
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

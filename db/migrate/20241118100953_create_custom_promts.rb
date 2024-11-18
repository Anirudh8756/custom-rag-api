class CreateCustomPromts < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_promts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :template

      t.timestamps
    end
  end
end

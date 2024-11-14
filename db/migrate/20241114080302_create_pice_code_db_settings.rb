class CreatePiceCodeDbSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :pice_code_db_settings do |t|
      t.string :url
      t.string :api_key

      t.timestamps
    end
  end
end

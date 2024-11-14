class CreateUrls < ActiveRecord::Migration[7.2]
  def change
    create_table :urls do |t|
      t.string :db_url
      t.string :api_key

      t.timestamps
    end
  end
end

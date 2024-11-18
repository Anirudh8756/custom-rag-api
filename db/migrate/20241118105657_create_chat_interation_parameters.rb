class CreateChatInterationParameters < ActiveRecord::Migration[7.2]
  def change
    create_table :chat_interation_parameters do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :max_token
      t.integer :temp
      t.boolean :logging

      t.timestamps
    end
  end
end

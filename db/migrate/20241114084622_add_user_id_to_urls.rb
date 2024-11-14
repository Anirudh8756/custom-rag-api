class AddUserIdToUrls < ActiveRecord::Migration[7.2]
  def change
    add_reference :urls, :user, null: false, foreign_key: true
  end
end

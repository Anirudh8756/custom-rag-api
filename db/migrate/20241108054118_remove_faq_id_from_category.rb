class RemoveFaqIdFromCategory < ActiveRecord::Migration[7.2]
  def change
    remove_column :categories, :faq_id
  end
end

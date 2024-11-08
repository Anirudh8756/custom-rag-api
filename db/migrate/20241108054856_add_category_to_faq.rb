class AddCategoryToFaq < ActiveRecord::Migration[7.2]
  def change
    add_reference :faqs, :category, null: true, foreign_key: true
  end
end

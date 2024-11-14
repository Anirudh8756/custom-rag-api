class ChangeDatabaseToPiceCodeDbConfig < ActiveRecord::Migration[7.2]
  def change
    rename_table :databases, :piceCodeDatabaseConfigs
  end
end

class RenameChatInteractionParametersToChatSettings < ActiveRecord::Migration[7.2]
  def change
    rename_table :chat_interation_parameters , :chat_interaction_parameters
  end
end

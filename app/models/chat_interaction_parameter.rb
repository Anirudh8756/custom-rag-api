class ChatInteractionParameter < ApplicationRecord
  belongs_to :user
  validates :max_token, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2048 }
  validates :temp, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
end

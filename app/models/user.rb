class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many_attached :upload

  validates :upload ,  content_type: ['application/pdf']
  has_many :messages , dependent: :destroy
  has_many :faqs, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end
end

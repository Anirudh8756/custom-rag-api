class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one_attached :upload
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload 
    super
  end
end
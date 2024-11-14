class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many_attached :upload
  has_one :url
  validates :upload, attached: true, content_type: [
    'application/pdf', # working
    'application/msword', # working
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'text/plain'
], if: -> { upload.attached? }
  validates_size_of :upload, maximum: 25.megabytes, message: "should be less than 25MB", if: -> { upload.attached? }
  has_many :messages , dependent: :destroy
  has_many :faqs, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end

end

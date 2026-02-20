class User < ApplicationRecord
  has_secure_password
  belongs_to :city
  has_many :gossips
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage" #set sender&recipient as ALIAS of PrivateMessage
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
  validates :password, presence: true, length: {minimum: 6}
  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update_attribute(:remember_digest, remember_digest)
  end
end

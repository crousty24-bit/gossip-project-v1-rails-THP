class Gossip < ApplicationRecord
  belongs_to :user
  has_many :join_table_gossip_tags, dependent: :destroy
  has_many :tags, through: :join_table_gossip_tags, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3, maximum: 14 }
  validates :content, presence: true
end

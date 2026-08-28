class Bid < ApplicationRecord
  has_many :bid_sources, dependent: :destroy
  has_many :sources, through: :bid_sources

  has_many :bid_documents, dependent: :destroy

  validates :title, presence: true
end
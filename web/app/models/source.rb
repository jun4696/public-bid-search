class Source < ApplicationRecord
  belongs_to :municipality

  has_many :bid_sources, dependent: :destroy
  has_many :bids, through: :bid_sources

  validates :name, presence: true
  validates :source_system, presence: true
  validates :url, presence: true
end
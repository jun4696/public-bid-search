class BidSource < ApplicationRecord
  belongs_to :bid
  belongs_to :source

  validates :format, presence: true
  validates :source_url, presence: true
  validates :fetched_at, presence: true
end
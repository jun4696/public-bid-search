class BidDocument < ApplicationRecord
  belongs_to :bid

  validates :name, presence: true
  validates :format, presence: true
  validates :url, presence: true
  validates :fetched_at, presence: true
end
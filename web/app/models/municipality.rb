class Municipality < ApplicationRecord
  has_many :sources, dependent: :destroy

  validates :name, presence: true
  validates :prefecture, presence: true
end
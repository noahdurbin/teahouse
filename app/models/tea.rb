class Tea < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates :brew_time, presence: true
  validates :price, presence: true

  has_many :subscriptions
  has_many :customers, through: :subscriptions
end

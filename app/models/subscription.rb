class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title, :price, :status, :frequency, :customer_id, :tea_id
end

class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title, :status, :frequency, :customer_id, :tea_id, :price
end

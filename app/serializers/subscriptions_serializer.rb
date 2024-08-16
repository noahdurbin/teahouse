class SubscriptionsSerializer
  def serialize(subscriptions)
    {
      data: [
        serialize_subscriptions(subscriptions)
      ]
    }
  end

  private

  def serialize_subscriptions(subscriptions)
    subscriptions.map do |subscription|
      SubscriptionSerializer.new(subscription)
    end
  end
end

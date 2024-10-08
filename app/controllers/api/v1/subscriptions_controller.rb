class Api::V1::SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.create(customer_id: subscription_params[:customer_id],
                                        tea_id: subscription_params[:tea_id])

    if @subscription.save
      render json: SubscriptionSerializer.new(@subscription), status: :created
    else
      render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    customer = Customer.find_by(id: params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionsSerializer.new.serialize(subscriptions), status: :ok
  end

  def destroy
    subscription = Subscription.find_by(id: params[:id])
    subscription.status = 'cancelled'

    render json: SubscriptionSerializer.new(subscription), status: :accepted
  end

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id)
  end
end

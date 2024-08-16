require 'rails_helper'

RSpec.describe 'subscriptions' do
  describe 'create a new subscription' do
    it 'has an endpoint for a user to create a subscription' do
      customer = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'johndoe@mail.com', address: 'home')
      tea = Tea.create!(title: 'Green Tea', description: 'Green Tea is a type of tea that is green.', temperature: 180,
                        brew_time: 3, price: 5)
      subscription_params = { customer_id: customer.id, tea_id: tea.id }

      post "/api/v1/customers/#{customer.id}/subscriptions", params: { subscription: subscription_params }

      expect(response).to be_successful
      expect(response.status).to eq(201)
      sub = JSON.parse(response.body, symbolize_names: true)

      expect(sub[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(sub[:data][:type]).to eq('subscription')

      # subscription title is the tea title by default
      expect(sub[:data][:attributes][:title]).to eq("John's Green Tea Subscription")
      # subscription is connected to customer and tea
      expect(sub[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(sub[:data][:attributes][:tea_id]).to eq(tea.id)
      # subscription status is active by default
      expect(sub[:data][:attributes][:status]).to eq('active')
      # subscription frequency is monthly by default
      expect(sub[:data][:attributes][:frequency]).to eq('monthly')
      # subscription price is the tea price by default
      expect(sub[:data][:attributes][:price]).to eq(5)
    end

    it 'fails gracefully if customer_id is missing' do
      customer = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'email@email.com', address: 'home')

      subscription_params = { customer_id: customer.id, tea_id: nil }

      post "/api/v1/customers/#{customer.id}/subscriptions", params: { subscription: subscription_params }

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:errors].first).to eq('Tea must exist')
    end
  end
end

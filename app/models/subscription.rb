class Subscription < ApplicationRecord
  after_initialize :set_title, :set_price, if: :new_record?

  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title, :status, :frequency, :customer_id, :tea_id

  # status defaults to 'active' in database
  # frequency defaults to 'monthly' in database
  enum status: %i[active cancelled]
  enum frequency: %i[weekly biweekly monthly bimonthly quarterly]

  private

  def set_title
    return unless customer_id.present? && tea_id.present?

    customer = Customer.find_by(id: customer_id)
    tea = Tea.find_by(id: tea_id)
    self.title = "#{customer.first_name}'s #{tea.title} Subscription"
  end

  def set_price
    return unless tea_id.present?

    tea = Tea.find_by(id: tea_id)
    self.price = tea.price
  end
end

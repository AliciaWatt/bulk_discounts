class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :discount
  validates_presence_of :quantity
  validates_numericality_of :quantity, :discount
  validates :discount, numericality: {greater_than_or_equal_to: 0.01, less_than_or_equal_to: 0.99}
  validates :quantity, numericality: {greater_than: 0}
end

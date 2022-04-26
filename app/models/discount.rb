class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :discount
  validates_presence_of :quantity
  validates_numericality_of :quantity, :discount
  validates :discount, inclusion: 0.1...0.99
  validates :quantity, numericality: {greater_than: 0}
end

require "rails_helper"

RSpec.describe "the merchant bulk discounts show" do
  it "exists" do
    merchant1 = Merchant.create!(name: "Show Page Sparkle")
    discount1 = merchant1.discounts.create!(discount: 20, quantity: 10)

    visit "/merchants/#{merchant1.id}/discounts/#{discount1.id}"

    expect(current_path).to eq("/merchants/#{merchant1.id}/discounts/#{discount1.id}")
  end

  it "has the discount's attributes" do
    merchant1 = Merchant.create!(name: "Show Page Sparkle")
    discount1 = merchant1.discounts.create!(discount: 20, quantity: 10)

    visit "/merchants/#{merchant1.id}/discounts/#{discount1.id}"

    within ".discount-attributes" do
      expect(page).to have_content("Discount : #{discount1.discount} %")
      expect(page).to have_content("Quantity Threshold: #{discount1.quantity}")
    end
  end
end

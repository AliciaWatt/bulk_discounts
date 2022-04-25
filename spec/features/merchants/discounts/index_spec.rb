require "rails_helper"

RSpec.describe "merchant discounts index" do
  it "displays merchants discounts and their information" do
    merchant1 = Merchant.create!(name: "Sample Merch")
    merchant2 = Merchant.create!(name: "Merchant Sample")

    discount_1 = merchant1.discounts.create!(quantity: 2, discount: 0.25)
    discount_2 = merchant1.discounts.create!(quantity: 4, discount: 0.75)
    discount_3 = merchant2.discounts.create!(quantity: 2, discount: 0.5)

    visit "/merchants/#{merchant1.id}/discounts"

    within ".discount-0" do
      expect(page).to have_link("Discount ID: #{discount_1.id}")
      expect(page).to have_content("#{discount_1.discount}% discount applied to quantity of #{discount_1.quantity} items.")
    end
    expect(page).to_not have_link("Discount ID: #{discount_3.id}")
    expect(page).to_not have_content("#{discount_3.discount}% discount applied to quantity of #{discount_1.quantity} items.")

    within ".discount-1" do
      expect(page).to have_link("Discount ID: #{discount_2.id}")
      expect(page).to have_content("#{discount_2.discount}% discount applied to quantity of #{discount_1.quantity} items.")
    end

    visit "/merchants/#{merchant1.id}/discounts"

    within ".discount-0" do
      click_on "Discount ID"
      expect(current_path).to eq("/merchants/#{merchants1.id}/discounts/#{discount_1.id}")
    end
  end
end

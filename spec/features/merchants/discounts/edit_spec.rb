require "rails_helper"
RSpec.describe "merchant discounts edit" do
  it "populates form with existing attributes" do
    merchant1 = Merchant.create!(name: "Edit Page Sparkle")
    discount1 = merchant1.discounts.create!(discount: 0.2, quantity: 10)
    # discount2 = merchant1.discounts.create!(discount: 0.5, quantity: 15)

    visit "/merchants/#{merchant1.id}/discounts/#{discount1.id}/edit"

    expect(page).to have_field(:quantity, with: 10)
    expect(page).to have_field(:discount, with: 0.2)

    fill_in(:quantity, with: 15)
    fill_in(:discount, with: 0.5)

    click_button("Update Discount")

    expect(current_path).to eq("/merchants/#{merchant1.id}/discounts/#{discount1.id}")

    expect(page).to have_content("Discount: 50.0 %")
    expect(page).to have_content("Quantity Threshold: 15")
    expect(page).not_to have_content("Discount: 10")
    expect(page).not_to have_content("Quantity: 5")

    expect(Discount.find(discount1.id).quantity).to eq(15)
    expect(Discount.find(discount1.id).discount).to eq(0.5)
  end
end

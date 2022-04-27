require "rails_helper"

RSpec.describe "merchant discounts index" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Sample Merch")
    @merchant2 = Merchant.create!(name: "Merchant Sample")
  end
  it "displays merchants discounts and their information" do
    discount = @merchant1.discounts.create!(quantity: 2, discount: 0.25)
    discount_2 = @merchant1.discounts.create!(quantity: 4, discount: 0.75)
    discount_3 = @merchant2.discounts.create!(quantity: 2, discount: 0.5)

    visit "/merchants/#{@merchant1.id}/discounts"

    within ".discount-#{discount.id}" do
      expect(page).to have_link("Discount ID: #{discount.id}")
      expect(page).to have_content("25% discount applied to the quantity of #{discount.quantity} items.")
    end
    expect(page).to_not have_link("Discount ID: #{discount_3.id}")
    expect(page).to_not have_content("50% discount applied to the quantity of #{discount_3.quantity} items.")

    within ".discount-#{discount_2.id}" do
      expect(page).to have_link("Discount ID: #{discount_2.id}")
      expect(page).to have_content("75% discount applied to the quantity of #{discount_2.quantity} items.")
    end

    visit "/merchants/#{@merchant1.id}/discounts"

    within ".discount-#{discount.id}" do
      click_on "Discount ID"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{discount.id}")
    end
  end

  it "has a link to create a new discount" do
    visit "/merchants/#{@merchant1.id}/discounts"

    within ".create-discount" do
      expect(page).to have_link("Create New Discount")
      click_link "Create New Discount"
    end

    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/new")
  end

  it "can delete a discount" do
    discount = @merchant1.discounts.create!(quantity: 2, discount: 0.25)
    discount_2 = @merchant1.discounts.create!(quantity: 4, discount: 0.75)
    discount_3 = @merchant2.discounts.create!(quantity: 2, discount: 0.5)

    visit "/merchants/#{@merchant1.id}/discounts"

    within ".discount-#{discount.id}" do
      expect(page).to have_link("Discount ID: #{discount.id}")
      expect(page).to have_content("25% discount applied to the quantity of #{discount.quantity} items.")
      expect(page).to have_link("Delete Discount")
      click_link "Delete Discount"
    end

    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")

    expect(page).to_not have_link("Discount ID: #{discount.id}")
    expect(page).to_not have_content("25% discount applied to the quantity of #{discount.quantity} items.")
  end

  it "shows the upcoming hoidays and dates" do
    merchants = FactoryBot.create_list(:merchant, 2)

    visit "/merchants/#{merchants[0].id}/discounts"

    expect(page).to have_content("Memorial Day")
    expect(page).to have_content("Juneteenth")
    expect(page).to have_content("Independence Day")
  end
end

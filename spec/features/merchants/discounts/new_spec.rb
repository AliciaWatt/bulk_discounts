require "rails_helper"

RSpec.describe "merchants discounts new page", type: :feature do
  it "allows the merchant to create a new discount" do
    merchant = FactoryBot.create_list(:merchant, 1).first

    visit "merchants/#{merchant.id}/discounts"
    click_on "Create New Discount"

    expect(current_path).to eq("/merchants/#{merchant.id}/discounts/new")

    fill_in :quantity, with: 5
    fill_in :discount, with: 0.22
    click_on "Submit"

    expect(current_path).to eq("/merchants/#{merchant.id}/discounts")
    expect(page).to have_content("22% discount applied to the quantity of 5 items.")
  end

  it "does not allow invalid inputs" do
    merchant = FactoryBot.create_list(:merchant, 1).first
    visit "/merchants/#{merchant.id}/discounts/new"

    fill_in :quantity, with: 10
    fill_in :discount, with: 102
    click_on "Submit"

    expect(current_path).to eq("/merchants/#{merchant.id}/discounts/new")
    expect(page).to have_content("Discount not created: Required information missing.")
  end
end

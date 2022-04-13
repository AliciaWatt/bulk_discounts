require "rails_helper"

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:transactions)}
  end

  describe "validations" do
    let!(:status) { %i[cancelled in_progress completed] }
  end

  describe "instance methods" do

  before :each do
    @merchant1 = Merchant.create!(name: "Schroeder-Jerde")
    @item1 = @merchant1.items.create!(name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est lauda...", unit_price: 75107)
    @item2 = @merchant1.items.create!(name: "Item Autem Minima", description: "Cumque consequuntur ad. Fuga tenetur illo molestia...", unit_price: 67076)
    @item3 = @merchant1.items.create!(name: "Item Ea Voluptatum", description: "Sunt officia eum qui molestiae. Nesciunt quidem cu...", unit_price: 32301)
    @customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: "cancelled")
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 75100, status: "shipped",)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 200000, status: "packaged",)
  end

    describe '.total_revenue' do 
      it 'calculates the total revenue on this invoice' do 
        expect(@invoice1.total_revenue).to eq(6751.00)
      end
    end
  end

end

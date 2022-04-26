class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.create
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.discounts.new(discount_params)
    if discount.save
      redirect_to "/merchants/#{merchant.id}/discounts"
    else
      redirect_to "/merchants/#{merchant.id}/discounts/new", notice: "Discount not created: Required information missing."
    end
  end

  private

  def discount_params
    params.required(:discount).permit(:discount, :quantity)
  end
end

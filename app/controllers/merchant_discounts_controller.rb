class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new(merchant_id: params[:merchant_id])
    # @merchant = Merchant.find(params[:merchant_id])
    # @discount = Discount.create
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.discounts.new(discount_params)
    redirect_to "/merchants/#{merchant.id}/discounts"
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchants/#{discount.merchant.id}/discounts"
  end

  private

  def discount_params
    params.required(:discount).permit(:discount, :quantity)
  end
end

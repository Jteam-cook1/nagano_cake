class Public::ShoppingAddressesController < ApplicationController

  def index
    @shopping_addresses = current_customer.shopping_addresses
    @shopping_address = ShoppingAddress.new
  end

  def edit
    @shopping_address = ShoppingAddress.find(params[:id])
    # @shopping_address = ShoppingAddress.new
  end

  def create
    @shopping_address = ShoppingAddress.new(shopping_address_params)
    @shopping_address.customer_id = current_customer.id
    if @shopping_address.save
      redirect_to shopping_addresses_path
    else
      @shopping_addresses = ShoppingAddress.all
      render :index
    end
  end

  def update
    @shopping_address = ShoppingAddress.find(params[:id])
    if @shopping_address.update(shopping_address_params)

      redirect_to shopping_addresses_path(@shopping_address.id)

    else
     render :edit
    end
  end

  def destroy
    @shopping_address = ShoppingAddress.find(params[:id])
    @shopping_address.destroy
    redirect_to shopping_addresses_path
  end

  private

  def shopping_address_params
    params.require(:shopping_address).permit(:postcode, :address, :name)
  end
end

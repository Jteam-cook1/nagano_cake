class Public::ShoppingAddressesController < ApplicationController

  def index
    @shopping_addresses = ShoppingAddress.all
    @shopping_address = ShoppingAddress.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end

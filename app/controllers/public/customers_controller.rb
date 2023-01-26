class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
  	@customer = Customer.find(params[:id])
  end

  def unsubscribe
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "会員情報が正常に保存されました"
      redirect_to customer_path(@customer)
    else
      render 'edit'
    end
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def customer_params
  	  params.require(:customer).permit(:is_active, :last_name, :first_name, :last_name_kana, :first_name_kana,
  	                                   :phone_number, :email, :password, :postcode, :address)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    if current_customer.id != @customer.id
      redirect_to root_path
    end
  end

end

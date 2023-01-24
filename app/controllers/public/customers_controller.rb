class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  # def show
  #   @customer = current_customer
  # end

  # def unsubscribe
  # end

  # def withdraw
  #   @customer = current_customer
  #   @customer.withdrawal_status = true
  #   if @customer.save
  #     reset_session
  #     redirect_to root_path
  #   end
  # end

  # def edit
  #   @customer = current_customer
  # end

  # def update
  #   @customer = current_customer
  #   @customer.update
  # end

  def show
  	@customer = Customer.find(params[:id])
  end

  def unsubscribe
    # @customer = Customer.find(customer_params)
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

  # def withdrawss
  #   @customer = current_customer
  #   @customer.withdrawal_status = true
  #   if @customer.save
  #     reset_session
  #     redirect_to root_path
  #   end
  # end

  def withdraw
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
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

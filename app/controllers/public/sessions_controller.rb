# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_withdraw_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # def new
  #   @customer = Customer.new
  # end

  # def create
  # customer = Customer.find_by(email: params[:session][:email])
  #   if customer && customer.authenticate(params[:session][:password])
  #     session[:customer_id] = customer.id
  #     redirect_to root_path
  #   else
  #     render :new
  #   end
  # end

  # def destroy
  #   @customer = Customer.find(params[:id])
  #   @customer.destroy
  #   redirect_to root_path
  # end

  protected

  # def reject_withdraw_customer
  #   @customer = Customer.find_by(email: params[:customer][:email].downcase)
  #   if @customer
  #     if (@customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == true))
  #       flash[:notice] = "退会済みのためログインできません。"
  #       redirect_to new_customer_session_path
  #     end
  #   end
  # end

  def reject_withdraw_customer
    @customer = Customer.find_by(email: params[:customer][:email].downcase)#登録したメールアドレスか確認する
    if @customer
      if (@customer.valid_password?(params[:customer][:password]) && @customer.is_active == false)#有効なパスワードか確認する→＆＆　退会しているか確認する
        flash[:notice] = "退会済みのためログインできません。"
        redirect_to new_customer_session_path
      end
    end
  end


  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end
  def after_sign_out_path_for(resource)
    new_customer_session_path
  end


   private
  def customer_params
  	  params.require(:customer).permit(:is_active, :email, :password)
  end
end




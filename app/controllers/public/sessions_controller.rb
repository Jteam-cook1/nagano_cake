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

  protected

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
    root_path(current_customer)
  end
  def after_sign_out_path_for(resource)
    root_path(current_customer)
  end

   private
  def customer_params
  	  params.require(:customer).permit(:is_active, :email, :password)
  end
end




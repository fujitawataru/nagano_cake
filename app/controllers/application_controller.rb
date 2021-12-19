class ApplicationController < ActionController::Base
     #下記のコメントアウトしているコードはadmin/controllerにも影響してしまうためそれぞれのcontrollerに記載。
     #before_action :authenticate_customer!,except: [:top, :about]
   before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,
    :last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:is_deleted])
  end
end

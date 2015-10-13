class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_filter :require_authentication!
  
  def create
    user = User.find_by(email: create_params[:email])
    if user && user.valid_password?(params[:user][:password])
      expose({
        user_id: user.id,
        token: user.authentication_token
      })
    else
      error! :unauthenticated,:metadata => {:custom_error_data => "xxxxxxxx"}
    end
  end

  private
  def create_params
    params.require(:user).permit(:email, :password)
  end
end

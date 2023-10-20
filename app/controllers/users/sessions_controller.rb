class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # authenticate_user with password and email
    self.resource = warden.authenticate!(auth_options.merge(strategy: :password_authenticatable))
    if resource&.active_for_authentication?
      if resource.otp_required_for_login?
        # Generate a signed token for user id
        verifier = Rails.application.message_verifier(:otp_session)
        token = verifier.generate(resource.id)
        session[:otp_token] = token

        sign_out(resource_name)
        redirect_to user_otp_path and return # this is the path to the otp page
      else
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource) and return
      end
    end
    # if the user is not active or the password is wrong
    flash[:alert] = 'Invalid email or password'
    redirect_to new_user_session_path
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

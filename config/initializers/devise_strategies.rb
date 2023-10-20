Warden::Strategies.add(:password_authenticatable) do
  def valid?
    params['user']&.fetch('email', nil) && params['user']&.fetch('password', nil)
  end

  def authenticate!
    user = User.find_by(email: params['user']['email'])
    if user&.valid_password?(params['user']['password'])
      success!(user)
    else
      fail!('Invalid email or password')
    end
  end
end
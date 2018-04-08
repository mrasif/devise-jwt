class Api::AuthController < Api::BaseController

  before_action :authenticate_request!, except: [:login, :register]
  # before_action :authenticate_request!, only: [:logout]

  def register
    @user=User.new(user_params)
    if @user.save
      render json: {status: true, message: 'User registered !', user: Api::UserSerializer.new(@user)}, status: 201
    else
      render json: {status: false, message: 'Failed to register !'}, status: 402
    end
  end

  def user
    @user=current_user
    render json: @user, status: 200
  end

  def update_user
    @user=User.find_by_email(params[:user][:email])
    # binding.pry
    if @user.update_attributes(user_params)
      render json: {status: true, message: 'User updated !', user: Api::UserSerializer.new(@user)}, status: 200
    else
      render json: {status: false, message: 'Failed to update !'}, status: 402
    end
  end

  def login
    user = User.find_for_database_authentication(email: params[:email])
    if user.valid_password?(params[:password])
      session[:user_id]=user.id
      render json: payload(user), status: 200
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def logout
    reset_session
    render json: {status: true, message: 'Logout successfully !'}, status: :ok
  end

  private
    def payload(user)
      return nil unless user and user.id
      {
        auth_token: JWToken.encode({user_id: user.id}),
        # user: {id: user.id, email: user.email, profile_attributes: user.profile}
        # send user using serializer
        user: Api::UserSerializer.new(user)
      }
    end

    def user_params
      params.require(:user).permit(:email, :password, profile_attributes: [:image, :name, :address, :age])
    end
end

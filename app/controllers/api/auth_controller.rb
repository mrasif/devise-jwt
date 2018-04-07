class Api::AuthController < Api::BaseController

  before_action :authenticate_request!, except: [:login, :register]
  # before_action :authenticate_request!, only: [:logout]

  def register
    @user=User.new(user_param)
    if @user.save
      render json: {status: true, message: 'User registered !', user: {id: @user.id, email: @user.email, profile_attributes: @user.profile}}, status: 201
    else
      render json: {status: false, message: 'Failed to register !'}, status: 402
    end
  end

  def user
    @user=current_user
    # render json: {status: true, message: 'User fetched !', user: @user.as_json(include:[:profile])}, status: :ok
    # render json: {status: true, message: 'User fetched !', user: {id: @user.id, email: @user.email, profile_attributes: {id: @user.profile.id, user_id: @user.profile.user_id, name: @user.profile.name, address: @user.profile.address, age: @user.profile.age, avtar_url: @user.profile.image.url}}}, status: :ok
    render json: @user, serializer: UserSerializer, status: 200
  end

  def update_user
    @user=User.find_by_email(params[:user][:email])
    @user.profile.name=params[:user][:profile_attributes][:name]
    @user.profile.address=params[:user][:profile_attributes][:address]
    @user.profile.age=params[:user][:profile_attributes][:age]
    if @user.save
      render json: {status: true, message: 'User updated !', user: {id: @user.id, email: @user.email, profile_attributes: @user.profile}}, status: 200
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
        user: user, serializer: Api::UserSerializer
      }
    end

    def user_param
      params.require(:user).permit(:email, :password, profile_attributes: [:image, :name, :address, :age])
    end
end

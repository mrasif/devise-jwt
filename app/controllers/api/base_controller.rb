class Api::BaseController < ActionController::Base
  # protect_from_forgery with: :exception
  attr_reader :current_user

  protected
    # Validates the token and user and sets the @current_user scope
    def authenticate_request!
      if !payload || !JWToken.valid_payload(payload.first)
        return invalid_authentication
      end
      load_current_user!
      invalid_authentication unless @current_user
    end

    # Returns 401 response. To handle malformed / invalid requests.
    def invalid_authentication
      render json: {status: false, message: 'Authentication failure.'}, status: :unauthorized
    end

  private
    # Deconstructs the Authorization header and decodes the JWT token.
    def payload
      auth_header = request.headers['Authorization']
      token = auth_header.split(' ').last
      JWToken.decode(token)
    rescue
      nil
    end

    # Sets the @current_user with the user_id from payload
    def load_current_user!
      # binding.pry
      @current_user = User.find_by(id: payload[0]['user_id'])
    end

end

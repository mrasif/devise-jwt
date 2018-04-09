class Api::BaseController < ActionController::Base
  # protect_from_forgery with: :exception
  attr_reader :current_user

  def render_data(data, status)
    render json: data, status: status, callback: params[:callback]
  end

  def render_error(message, code='internal_server_error', status = 400, data={})
    payload = { success: false, status: status, code: code, message: message }
    payload[:data] = data if data.present?
    render_data(payload, status)
  end

  def render_success(data, status = 200)
    if data.is_a? String
      render_data({ message: data }, status)
    else
      render_data(data, status)
    end
  end

  protected
    # Validates the token and user and sets the @current_user scope
    def authenticate_request!
      # binding.pry
      if !payload || !JWToken.valid_payload(payload.first)
        return invalid_authentication
      end
      load_current_user!
      invalid_authentication unless @current_user
    end

    # Returns 401 response. To handle malformed / invalid requests.
    def invalid_authentication
      render_error 'Authentication failure', 'unauthorized', 401
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
      @current_user = User.find_by(id: payload[0]['user_id'])
    end

end

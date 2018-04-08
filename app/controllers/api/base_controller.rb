class Api::BaseController < ActionController::Base
  # protect_from_forgery with: :exception
  attr_reader :current_user

  # def render_json_api(resource, options = {})
  #   options[:adapter] ||= :json_api
  #   options[:namespace] ||= Api
  #   options[:key_transform] ||= :camel_lower
  #   options[:serialization_context] ||= ActiveModelSerializers::SerializationContext.new(request)
  #   ActiveModelSerializers::SerializableResource.new(resource, options)
  # end
  #
  # def render_success(status, resource, options = {})
  #   options[:meta] ||= {}
  #   render json: render_json_api(resource, options).as_json, status: status
  # end
  #
  # def render_error(status, errors = [], meta = {})
  #   render json: { errors: errors, meta: meta }, status: status
  # end

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: { status: false, errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
    render json: { status: false, errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private
  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JWToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i && session[:user_id]
  end
end

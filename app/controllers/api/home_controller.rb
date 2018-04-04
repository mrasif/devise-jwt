class Api::HomeController < Api::BaseController
  # before_filter :authenticate_request!
  before_action :authenticate_request!

  def index
    render json: {'logged_in' => true}, status: :ok
  end
end

class HomeController < ApplicationController
  # before_action :authenticate_request!

  def index
    # @notes=Note.all
    # render json: {status: true, message: 'Note fetched !', notes: @notes}, status: :ok
  end
end

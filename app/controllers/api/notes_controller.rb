class Api::NotesController < Api::BaseController
  before_action :authenticate_request!
  def create
    @note=current_user.notes.new(note_params)
    # binding.pry
    if @note.save
      render json: {status: true, message: 'Note created !', note: @note}, status: 201
    else
      render json: {status: true, message: 'Failed to create note !'}, status: 402
    end
  end

  private
  def note_params
    params.require(:note).permit(:title, :body)
  end
end

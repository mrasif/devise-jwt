class Api::NotesController < Api::BaseController
  before_action :authenticate_request!

  def index
    @notes=current_user.notes
    render json: {status: true, message: 'Note fetched !', notes: @notes}, status: 200
  end

  def create
    @note=current_user.notes.new(note_params)
    # binding.pry
    if @note.save
      render json: {status: true, message: 'Note created !', note: @note}, status: 201
    else
      render json: {status: false, message: 'Failed to create note !'}, status: 402
    end
  end

  def update
    @note=current_user.notes.find_by_id(params[:note][:id])
    if @note==nil
      render json: {status: false, message: 'Note not found !'}, status: 404
      return
    end
    @note.title=params[:note][:title]
    @note.body=params[:note][:body]
    if @note.save
      render json: {status: true, message: 'Note updated !', note: @note}, status: 200
    else
      render json: {status: false, message: 'Failed to update note !'}, status: 402
    end
  end

  def destroy
    @note=current_user.notes.find_by_id(params[:note][:id])
    if @note==nil
      render json: {status: false, message: 'Note not found !'}, status: 404
      return
    end
    if @note.delete
      render json: {status: true, message: 'Note deleted !', note: @note}, status: 200
    else
      render json: {status: false, message: 'Failed to delete note !'}, status: 402
    end
  end

  private
  def note_params
    params.require(:note).permit(:title, :body)
  end
end

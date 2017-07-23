class NotesController < ApplicationController
	def create
		params[:user_id] = current_user.id
		@note = Note.new(note_params)

    if @note.save
      redirect_to Application.find(@note.application_id), notice: 'Note was successfully created.'
    else
      redirect_to applications_path, notice: "Something went wrong"
    end
	end

	private

		def note_params
			params.require(:note).permit(:application_id, :body, :user_id)
		end
end

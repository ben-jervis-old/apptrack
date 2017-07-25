module NotesHelper
	include ActionView::Helpers::DateHelper

	def relative_time(input_time)
		"#{time_ago_in_words(input_time)} ago"
	end
end

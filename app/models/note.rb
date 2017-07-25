class Note < ApplicationRecord
	include NotesHelper
	
  belongs_to :user
  belongs_to :application

	def display_time
		if self.created_at.localtime.to_date == Date.today
			relative_time(self.created_at.localtime)
		else
			self.created_at.localtime.strftime('%l:%m%P %d/%m/%y')
		end
	end

end

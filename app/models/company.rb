class Company < ApplicationRecord
	has_many :applications
	has_many :users
	has_many :lenders
	has_many :activities
end

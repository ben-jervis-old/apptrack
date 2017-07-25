class Company < ApplicationRecord
	has_many :applications
	has_many :users
	has_many :lenders
	has_many :activities

	accepts_nested_attributes_for :users

	validates :name, presence: true
	validates_associated :users
end

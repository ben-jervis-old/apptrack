class CompaniesController < ApplicationController

	skip_before_action :require_login, only: [:new, :create]

	def new
		@company = Company.new
		@company.users.new
	end

	def create
		@company = Company.new(company_params)
		@company.users.first.level = 'admin'
		@company.users.first.activated = true

		if @company.save
			log_in(@company.users.first)
			redirect_to root_url
		else
			render 'sessions/new'
		end

	end

	private

		def company_params
			params.require(:company).permit(:name, users_attributes: [:first_name, :last_name, :email, :password, :password_confirmation])
		end
end

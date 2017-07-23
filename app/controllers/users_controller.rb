class UsersController < ApplicationController
	
	before_action :set_user, only: [:edit, :show, :update, :destroy, :update_password]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def edit
	end

	def show
	end

	def update
    if @user.update_attributes(user_params)
			flash[:success] = "Details updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
	end

	def update_password
		if @user.update_attributes(password_params_only)
			flash[:success] = "Your password has been updated"
			#TODO email password update notification
			redirect_to @user
		else
			render 'update_password'
		end
	end

	def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			#TODO Setup heroku email sending https://www.railstutorial.org/book/account_activation#sec-activation_email_in_production
			log_in @user
			flash[:success] = "Please check your email to activate your account"
			redirect_to root_url
		else
			render 'new'
		end
	end

	private

		def set_user
			@user = User.find(params[:id])
		end

    def user_params
			params[:user][:level] ||= 'staff'
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :level)
    end
end

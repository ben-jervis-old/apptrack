class ApplicationsController < ApplicationController
	before_action :set_application, only: [:show, :edit, :update, :destroy]
	before_action :set_lists,				only: [:edit, :new]

  # GET /applications
  # GET /applications.json
  def index
    @applications = current_user.company.applications
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
		this_company = current_user.company
		@notes = @application.notes.all
		@note = @application.notes.build
		@note.user_id = current_user.id
		@owner = User.find(@application.owner_id)
		@activity_type = this_company.activities.find(@application.activity_id).name
		@lender_name = this_company.lenders.find(@application.lender_id).name
  end

  # GET /applications/new
  def new
		this_company = current_user.company
    @application = this_company.applications.build
		@cancel_path = applications_path
  end

  # GET /applications/1/edit
  def edit
		@cancel_path = application_path(@application)
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)
    if @application.save
			flash[:success] = 'Application was successfully created.'
      redirect_to @application
    else
      render :new
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    if @application.update(application_params)
			flash[:success] = 'Application was successfully updated.'
			redirect_to @application
    else
    	render :edit
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
		# Set the lists for select tags
		def set_lists
			this_company = current_user.company
			@user_options_list = this_company.users.sort_by(&:name).map{ |usr| [usr.name, usr.id] }
			lenders = this_company.lenders.sort_by(&:name)
			@fav_lenders = lenders.select(&:favourite)
			@other_lenders =lenders.reject(&:favourite)
			@activity_options_list = this_company.activities.sort_by(&:name).map{ |act| [act.name, act.id] }.unshift(['Choose an activity...', 0])
		end

    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:name, :amount, :lender_id, :activity_id, :owner_id, :waiting_on, :company_id)
    end
end

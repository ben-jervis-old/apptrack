class ApplicationsController < ApplicationController
	before_action :set_application, only: [:show, :edit, :update, :destroy]

  # GET /applications
  # GET /applications.json
  def index
    @applications = current_user.company.applications
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
		@notes = @application.notes.all
		@note = @application.notes.build
		@note.user_id = current_user.id
		@owner = User.find(@application.owner_id)
  end

  # GET /applications/new
  def new
    @application = current_user.company.applications.build
  end

  # GET /applications/1/edit
  def edit
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
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:name, :amount, :lender, :activity, :owner_id, :waiting_on, :company_id)
    end
end

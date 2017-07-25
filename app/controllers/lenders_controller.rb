class LendersController < ApplicationController
  before_action :set_lender, only: [:show, :edit, :update, :destroy]

  # GET /lenders
  # GET /lenders.json
  def index
    @lenders = Lender.all.sort_by(&:name)
		respond_to do |format|
			format.html
			format.json { render json: @lenders }
		end
  end

  # GET /lenders/1
  # GET /lenders/1.json
  def show
  end

  # GET /lenders/new
  def new
    @lender = Lender.new
  end

  # GET /lenders/1/edit
  def edit
  end

  # POST /lenders
  # POST /lenders.json
  def create
    @lender = Lender.new(lender_params)
		@lender.company_id = current_user.company_id

    respond_to do |format|
      if @lender.save
        format.html { redirect_to @lender, notice: 'Lender was successfully created.' }
        format.json { render json: @lender }
      else
        format.html { render :new }
        format.json { render json: { errors: @lender.errors.messages }, status: 422 }
      end
    end
  end

  # PATCH/PUT /lenders/1
  # PATCH/PUT /lenders/1.json
  def update
    respond_to do |format|
      if @lender.update(lender_params)
        format.html { redirect_to @lender, notice: 'Lender was successfully updated.' }
        format.json { render json: @lender }
      else
        format.html { render :edit }
        format.json { render json: { errors: @lender.errors.messages }, status: 422 }
      end
    end
  end

  # DELETE /lenders/1
  # DELETE /lenders/1.json
  def destroy
    @lender.destroy
    respond_to do |format|
      format.html { redirect_to lenders_url, notice: 'Lender was successfully destroyed.' }
      format.json { render json: {}, status: :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lender
      @lender = Lender.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lender_params
      params.require(:lender).permit(:name, :favourite)
    end
end

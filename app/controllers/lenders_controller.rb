class LendersController < ApplicationController
  before_action :set_lender, only: [:show, :edit, :update, :destroy]

	belongs_to :company

  # GET /lenders
  # GET /lenders.json
  def index
    @lenders = Lender.all
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

    respond_to do |format|
      if @lender.save
        format.html { redirect_to @lender, notice: 'Lender was successfully created.' }
        format.json { render :show, status: :created, location: @lender }
      else
        format.html { render :new }
        format.json { render json: @lender.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lenders/1
  # PATCH/PUT /lenders/1.json
  def update
    respond_to do |format|
      if @lender.update(lender_params)
        format.html { redirect_to @lender, notice: 'Lender was successfully updated.' }
        format.json { render :show, status: :ok, location: @lender }
      else
        format.html { render :edit }
        format.json { render json: @lender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lenders/1
  # DELETE /lenders/1.json
  def destroy
    @lender.destroy
    respond_to do |format|
      format.html { redirect_to lenders_url, notice: 'Lender was successfully destroyed.' }
      format.json { head :no_content }
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

class CleanersController < ApplicationController
  before_action :set_cleaner, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!
  before_filter :set_cleaner, only: [:show]
  # GET /cleaners
  # GET /cleaners.json
  def index
    @cleaners = Cleaner.all
  end
  # GET /cleaners/1
  # GET /cleaners/1.json
  def show
  end
  # GET /cleaners/new
  def new
    @cleaner = Cleaner.new
  end
  # GET /cleaners/1/edit
  def edit
  end
  # POST /cleaners
  # POST /cleaners.json
  def create
    @cleaner = Cleaner.new(cleaner_params)
    @cities_ids = params[:cleaner][:city_ids]
    respond_to do |format|
      if @cleaner.save
        @cities_ids.each do |i|
          CleanerCity.create!(cleaner_id: @cleaner.id, city_id: i)if (@cities_ids.present?)
        end
        format.html { redirect_to @cleaner, notice: 'Cleaner was successfully created.' }
        format.json { render :show, status: :created, location: @cleaner }
      else
        format.html { render :new }
        format.json { render json: @cleaner.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /cleaners/1
  # PATCH/PUT /cleaners/1.json
  def update
    respond_to do |format|
      if @cleaner.update(cleaner_params)
        format.html { redirect_to @cleaner, notice: 'Cleaner was successfully updated.' }
        format.json { render :show, status: :ok, location: @cleaner }
      else
        format.html { render :edit }
        format.json { render json: @cleaner.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /cleaners/1
  # DELETE /cleaners/1.json
  def destroy
    @cleaner.destroy
    respond_to do |format|
      format.html { redirect_to cleaners_url, notice: 'Cleaner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cleaner
      @cleaner = Cleaner.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def cleaner_params
      params.require(:cleaner).permit(:first_name, :last_name, :quality_score, :email, :city_ids)
    end
end

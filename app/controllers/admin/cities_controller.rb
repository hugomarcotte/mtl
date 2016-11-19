class Admin::CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

  # GET /admin/cities
  def index
    @cities = City.all
  end

  # GET /admin/cities/1
  def show
  end

  # GET /admin/cities/new
  def new
    @city = City.new
  end

  # GET /admin/cities/1/edit
  def edit
  end

  # POST /admin/cities
  def create
    @city = City.new(city_params)

    if @city.save
      flash.alert = 'City was successfully created.'
      redirect_to [:admin, @city]
    else
      render :new
    end
  end

  # PATCH/PUT /admin/cities/1
  def update
    if @city.update(city_params)
      flash.alert = 'City was successfully updated.'
      redirect_to [:admin, @city]
    else
      render :edit
    end
  end

  # DELETE /admin/cities/1
  def destroy
    @city.destroy
    flash.alert = 'City was successfully destroyed.'
    redirect_to admin_cities_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def city_params
      params.require(:city).permit(:name)
    end
end

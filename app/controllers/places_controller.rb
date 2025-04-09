class PlacesController < ApplicationController
  before_action :set_place, only: [:edit, :update, :destroy]

  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)

    if @place.save
      redirect_to places_path, notice: "Place created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      redirect_to places_path, notice: "Place updated successfully"
    else
      render :edit
    end
  end

  def destroy
    if @place.events.any?
      redirect_to places_path, alert: "Cannot delete place with associated events"
    else
      @place.destroy
      redirect_to places_path, notice: "Place deleted successfully"
    end
  end

  private
  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name)
  end
end

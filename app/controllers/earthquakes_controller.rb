class EarthquakesController < ApplicationController
  before_action :set_earthquake, only: [:show, :update, :destroy]

  # GET /earthquakes (with pagination)
  def index
    earthquakes = Rails.cache.fetch("earthquakes_page_#{params[:page]}", expires_in: 12.hours) do
      Earthquake.page(params[:page]).per(20)
    end
    render json: earthquakes
    # earthquakes = Earthquake.page(params[:page]).per(20)
    # render json: earthquakes
  end

  # GET /earthquakes/:id
  def show
    render json: @earthquake
  end

  # POST /earthquakes
  def create
    earthquake = Earthquake.new(earthquake_params)

    if earthquake.save
      render json: earthquake, status: :created
    else
      render json: earthquake.errors, status: :unprocessable_entity
    end
  end

  # PUT /earthquakes/:id
  def update
    if @earthquake.update(earthquake_params)
      render json: @earthquake
    else
      render json: @earthquake.errors, status: :unprocessable_entity
    end
  end

  # DELETE /earthquakes/:id
  def destroy
    @earthquake.destroy
  end

  private

  def set_earthquake
    @earthquake = Earthquake.find(params[:id])
  end

  def earthquake_params
    params.require(:earthquake).permit(:location, :magnitude, :depth, :occurred_at)
  end
end

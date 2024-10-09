class Api::V1::EarthquakesController < ApplicationController
    # before_action :doorkeeper_authorize!
    before_action :set_earthquake, only: [:show, :update, :destroy]
  
    # GET /earthquakes (with pagination)
    def index
      page = params[:page] || 1
      cache_key = "earthquakes_page_#{page}"
      
      # Try to fetch the data from Redis cache
      earthquakes = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
        Earthquake.page(page).per(20).to_a
      end
  
      # Render the response with pagination metadata
      render json: {
        data: earthquakes,
        pagination: {
          current_page: page.to_i,
          total_pages: Earthquake.page(page).total_pages,
          total_count: Earthquake.page(page).total_count
        }
      }
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
  
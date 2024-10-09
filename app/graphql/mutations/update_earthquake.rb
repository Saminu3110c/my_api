# frozen_string_literal: true
module Mutations
    class UpdateEarthquake < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :location, String, required: false
      argument :magnitude, Float, required: false
      argument :depth, Float, required: false
      argument :occurred_at, GraphQL::Types::ISO8601DateTime, required: false
  
      field :earthquake, Types::EarthquakeType, null: true
      field :errors, [String], null: false
  
      def resolve(id:, location: nil, magnitude: nil, depth: nil, occurred_at: nil)
        earthquake = Earthquake.find_by(id: id)
        return { earthquake: nil, errors: ['Earthquake not found'] } unless earthquake
  
        if earthquake.update(location: location, magnitude: magnitude, depth: depth, occurred_at: occurred_at)
          { earthquake: earthquake, errors: [] }
        else
          { earthquake: nil, errors: earthquake.errors.full_messages }
        end
      end
    end
  end
  
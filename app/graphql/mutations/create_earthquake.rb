# frozen_string_literal: true

module Mutations
    class CreateEarthquake < Mutations::BaseMutation
      argument :location, String, required: true
      argument :magnitude, Float, required: true
      argument :depth, Float, required: true
      argument :occurred_at, GraphQL::Types::ISO8601DateTime, required: true
  
      field :earthquake, Types::EarthquakeType, null: true
      field :errors, [String], null: false
  
      def resolve(location:, magnitude:, depth:, occurred_at:)
        earthquake = Earthquake.new(location: location, magnitude: magnitude, depth: depth, occurred_at: occurred_at)
        if earthquake.save
          { earthquake: earthquake, errors: [] }
        else
          { earthquake: nil, errors: earthquake.errors.full_messages }
        end
      end
    end
  end
  
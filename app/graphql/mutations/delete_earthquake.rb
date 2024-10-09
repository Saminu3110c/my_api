# frozen_string_literal: true

module Mutations
    class DeleteEarthquake < Mutations::BaseMutation
      argument :id, ID, required: true
  
      field :earthquake, Types::EarthquakeType, null: true
      field :errors, [String], null: false
  
      def resolve(id:)
        earthquake = Earthquake.find_by(id: id)
        return { earthquake: nil, errors: ['Earthquake not found'] } unless earthquake
  
        if earthquake.destroy
          { earthquake: earthquake, errors: [] }
        else
          { earthquake: nil, errors: earthquake.errors.full_messages }
        end
      end
    end
  end
  
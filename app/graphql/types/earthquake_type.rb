module Types
    class EarthquakeType < Types::BaseObject
      field :id, ID, null: false
      field :location, String, null: false
      field :magnitude, Float, null: false
      field :depth, Float, null: false
      field :occurred_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
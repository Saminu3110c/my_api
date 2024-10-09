# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_earthquake, mutation: Mutations::CreateEarthquake
    field :update_earthquake, mutation: Mutations::UpdateEarthquake
    field :delete_earthquake, mutation: Mutations::DeleteEarthquake
  end
end

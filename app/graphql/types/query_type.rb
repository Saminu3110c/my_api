# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :earthquakes, [Types::EarthquakeType], null: false, description: "Fetches a paginated list of earthquakes." do
      argument :page, Integer, required: false, description: "The page number for pagination."
      argument :per_page, Integer, required: false, description: "The number of records per page."
      argument :magnitude_greater_than, Float, required: false, description: "Filter by magnitude greater than."
    end

    def earthquakes(page: 1, per_page: 20, magnitude_greater_than: nil)
      scope = Earthquake.all
      scope = scope.where('magnitude > ?', magnitude_greater_than) if magnitude_greater_than
      scope.page(page).per(per_page)
    end
  end
end

# module Types
#   class QueryType < Types::BaseObject
#     field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
#       argument :id, ID, required: true, description: "ID of the object."
#     end

#     def node(id:)
#       context.schema.object_from_id(id, context)
#     end

#     field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
#       argument :ids, [ID], required: true, description: "IDs of the objects."
#     end

#     def nodes(ids:)
#       ids.map { |id| context.schema.object_from_id(id, context) }
#     end

#     # Add root-level fields here.
#     # They will be entry points for queries on your schema.

#     # Earthquakes query field
#     field :earthquakes, [Types::EarthquakeType], null: false, description: "Fetches a paginated list of earthquakes." do
#       argument :page, Integer, required: false, description: "The page number for pagination."
#     end

#     def earthquakes(page: 1)
#       Earthquake.page(page).per(20)
#     end

#     # Example field (can be removed)
#     field :test_field, String, null: false, description: "An example field added by the generator"
#     def test_field
#       "Hello World!"
#     end
#   end
# end

# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  config.openapi_root = Rails.root.join('swagger').to_s

    # Define one or more Swagger documents and provide global metadata for each one
    config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          Earthquake: {
            type: :object,
            properties: {
              id: { type: :integer },
              magnitude: { type: :number, format: :float },
              location: { type: :string },
              occurred_at: { type: :string, format: :date_time }
            },
            required: ['id', 'magnitude', 'location', 'occurred_at']
          }
        }
      },
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ]
    }
  }


  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  config.openapi_format = :yaml
end

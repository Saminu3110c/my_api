require 'swagger_helper'

RSpec.describe 'Earthquake API', type: :request do
  path '/earthquakes' do
    get 'List all earthquakes' do
      tags 'Earthquakes'
      produces 'application/json'
      
      response '200', 'Earthquake response' do
        schema type: :array do
          items do
            key :'$ref', :Earthquake
          end
        end
        
        run_test!
      end
    end
  end
end

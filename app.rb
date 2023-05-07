ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/url_for'
require 'fast_jsonapi'
require 'kaminari'

require 'pry'

require_relative 'app/models/ad'
require_relative 'app/helpers/pagination_links'
require_relative 'app/serializers/ad_serializer'
require_relative 'app/serializers/error_serializer'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  helpers Sinatra::UrlForHelper
  include PaginationLinks

  # Usage example:
  # curl -v http://127.0.0.1:3000
  get '/' do
    content_type :json

    ads = Ad.order(updated_at: :desc).page(params[:page])
    serializer = AdSerializer.new(ads, links: pagination_links(ads, request))
    serializer.serialized_json
  end

  # Usage example:
  # curl -v -X POST -H "Content-Type: application/json" -d \
  #   '{"title": "Title", "description": "Description", "city": "City", "user_id": 5}' http://127.0.0.1:3000/ads
  post '/ads' do
    content_type :json

    request.body.rewind
    data = JSON.parse(request.body.read)
    ad_params = data.slice 'title', 'description', 'city', 'user_id'

    ad = Ad.new(ad_params)

    if ad.save
      serializer = AdSerializer.new(ad)
      status :created
      serializer.serialized_json
    else
      status :unprocessable_entity
      ErrorSerializer.from_model(ad).to_json
    end
  end

  run! if app_file == $0
end

ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/url_for'
require 'fast_jsonapi'
require 'kaminari'

require_relative 'app/models/ad'
require_relative 'app/helpers/pagination_links'
require_relative 'app/serializers/ad_serializer'
require_relative 'app/serializers/error_serializer'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  helpers Sinatra::UrlForHelper
  include PaginationLinks

  get '/' do
    content_type :json
    ads = Ad.order(updated_at: :desc).page(params[:page])
    serializer = AdSerializer.new(ads, links: pagination_links(ads, request))
    serializer.serialized_json
  end

  post '/ads' do
    ad_params = params.slice(:title, :description, :city, :user_id)
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

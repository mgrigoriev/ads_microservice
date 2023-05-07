ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/url_for'
require 'fast_jsonapi'
require 'kaminari'
require 'pry'

require_relative 'app/models/ad'
require_relative 'app/serializers/ad_serializer'
require_relative 'app/serializers/error_serializer'
require_relative 'app/lib/pagination_links'
require_relative 'app/lib/api_errors'
require_relative 'app/services/ads/create_service'

class App < Sinatra::Base
  include PaginationLinks
  include ApiErrors

  register Sinatra::ActiveRecordExtension

  helpers Sinatra::UrlForHelper

  get '/' do
    content_type :json

    ads = Ad.order(updated_at: :desc).page(params[:page])
    serializer = AdSerializer.new(ads, links: pagination_links(ads, request))
    serializer.serialized_json
  end

  post '/ads' do
    request.body.rewind
    data = JSON.parse(request.body.read)
    ad_params = data.fetch('ad').slice 'title', 'description', 'city', 'user_id'

    result = Ads::CreateService.call(ad: ad_params)

    if result.success?
      serializer = AdSerializer.new(result.ad)
      content_type :json
      status 201
      body serializer.serialized_json
    else
      error_response(result.ad, 422)
    end
  rescue StandardError => e
    handle_exception(e)
  end
end

require_relative '../spec_helper'

require 'pry'

describe "Ads API", type: :request do
  describe 'GET /' do
    before do
      create_list(:ad, 3)
    end

    it 'returns a collection of ads' do
      get '/'

      # binding.pry

      expect(last_response).to be_ok
      expect(response_body['data'].size).to eq(3)
    end
  end
end

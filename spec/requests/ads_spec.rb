require_relative '../spec_helper'

require 'pry'

describe "Ads API", type: :request do
  describe 'GET /' do
    before do
      create_list(:ad, 3)
    end

    it 'returns a collection of ads' do
      get '/'

      expect(last_response).to be_ok
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /ads (valid auth token)' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/ads', {}.to_json

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:ad_params) do
        {
          user_id: 1,
          title: 'Ad title',
          description: 'Ad description',
          city: ''
        }
      end

      it 'returns an error' do
        post '/ads', { ad: ad_params }.to_json

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
                                             {
                                               'detail' => "can't be blank",
                                               'source' => {
                                                 'pointer' => '/data/attributes/city'
                                               }
                                             }
                                           )
      end
    end

    context 'valid parameters' do
      let(:ad_params) do
        {
          user_id: 1,
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { Ad.last }

      it 'creates a new ad' do
        expect { post '/ads', { ad: ad_params }.to_json }
          .to change { Ad.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an ad' do
        post '/ads', { ad: ad_params }.to_json

        expect(response_body['data']).to include(
                                           'id' => last_ad.id.to_s,
                                           'type' => 'ad'
                                         )
      end
    end
  end
end

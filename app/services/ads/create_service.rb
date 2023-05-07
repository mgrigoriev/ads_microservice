module Ads
  class CreateService
    attr_reader :ad, :errors

    def self.call(ad:)
      new(ad: ad).call
    end

    def initialize(ad:)
      @add_params = ad
      @errors = []
    end

    def call
      @ad = Ad.new(@add_params.to_h)
      @errors = @ad.errors.full_messages unless @ad.save

      self
    end

    def success?
      errors.empty?
    end
  end
end

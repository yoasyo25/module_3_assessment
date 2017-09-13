class SearchController < ApplicationController

  def index
    @bestbuy_locations = BestBuyStore.find_closeby_stores(zip)
  end

  private
    def zip
      params[:search]
    end
end

class BestBuyStore
  attr_reader :name, :city, :distance, :phone_number, :store_type

  def initialize(attributes = {})
    @name = attributes[:longName]
    @city = attributes[:city]
    @distance = attributes[:distance]
    @phone_number = attributes[:phone]
    @store_type = attributes[:storeType]
  end

  def self.find_closeby_stores(zip)
    results = BestBuyService.find_closeby_stores(zip)

    results.map do |result|
      new(result)
    end
  end
end

class BestBuyService

  def initialize(zip)
    @zip = zip
    @conn = Faraday.new(url: "https://api.bestbuy.com/v1")
  end

  def find_closeby_stores(zip)
    response = @conn.get ("stores((area(#{@zip},25)))?apiKey=#{ENV["API_KEY"]}&show=city,longName,phone,distance,storeType&pageSize=20&format=json")
    results  = JSON.parse(response.body, symbolize_names: true)[:stores]
  end

  def self.find_closeby_stores(zip)
    new(zip).find_closeby_stores(zip)
  end
end

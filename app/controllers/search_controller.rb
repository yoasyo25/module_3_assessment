class SearchController < ApplicationController

  def index
    @zip = params[:search]

    @conn = Faraday.new(url: "https://api.bestbuy.com/v1")
    response = @conn.get ("stores((area(#{@zip},25)))?apiKey=#{ENV["API_KEY"]}&show=city,longName,phone,distance,storeType&pageSize=20&format=json")

    results = JSON.parse(response.body, symbolize_names: true)[:stores]
    binding.pry
    @bestbuy_locations = results.map do |result|
      BestBuyStore.new(result)
    end
  end
end

class BestBuyStore

  attr_reader :name, :city, :distance, :phone_number, :store_type

  def initialize(attributes = {})
    @name = attributes[]


end


{
  "from": 1,
  "to": 17,
  "currentPage": 1,
  "total": 17,
  "totalPages": 1,
  "queryTime": "0.022",
  "totalTime": "0.037",
  "partial": false,
  "canonicalUrl": "/v1/stores((area(\"80202\",25)))?show=city,longName,phone,storeType&pageSize=20&format=json&apiKey=445jt4mb4gsenju48n2ndu8d",
  "stores": [
    {
      "city": "Denver",
      "longName": "Cherry Creek Shopping Center",
      "phone": "303-270-9189",
      "storeType": "Mobile SAS"
    },

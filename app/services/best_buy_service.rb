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

  def store_count(zip)
    response = @conn.get("stores((area(#{@zip},25)))?apiKey=#{ENV["API_KEY"]}")
    binding.pry
    result = JSON.parse(response.bod, symbolize_names: true)
  end

  def self.store_count(zip)
    new(zip).store_count(zip)
  end


end

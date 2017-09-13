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

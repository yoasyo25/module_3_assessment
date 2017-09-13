class SearchController < ApplicationController

  def index
    @bestbuy_locations = BestBuyStore.find_closeby_stores(zip)
  end

  private
    def zip
      params[:search]
    end
end

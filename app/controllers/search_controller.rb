class SearchController < ApplicationController

  def index
    @bestbuy_locations = BestBuyStore.find_closeby_stores(zip)
    @bestbuy_store_count = BestBuyService.store_count(zip)
  end

  private
    def zip
      params[:search]
    end
end

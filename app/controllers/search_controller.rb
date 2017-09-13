class SearchController < ApplicationController

  def index
    @zip = params[:seach]
  end

end

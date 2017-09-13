class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def destroy
    Item.find(params[:id]).destroy
    head :no_content
  end

  def create
    render json: Item.create(item_params), status: :created
  end

  private
    def item_params
      params.permit(:name, :description, :image_url)
    end
end

class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  respond_to :json

  swagger_controller :items, 'Items'

  swagger_api :index do
    summary 'Returns all items'
    notes 'All the items'
  end


  # GET /items
  def index
    @items = Item.all

    render json: @items, status: :ok
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :description, :price)
    end
end

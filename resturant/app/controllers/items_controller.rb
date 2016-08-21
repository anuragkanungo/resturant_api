class ItemsController < ApplicationController
  include Swagger::Docs::ImpotentMethods
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :authenticate_request, only: [:new, :create, :edit, :save]

  swagger_controller :items, 'Items'

  swagger_api :index do
    summary 'Returns all items'
    notes "This lists all the active users"
    param :query, :page, :integer, :optional, "Page number"
    response :requested_range_not_satisfiable
  end

  swagger_api :show do
    summary "Fetches a single Item"
    param :path, :id, :integer, :optional, "Item Id"
    response :ok, "Success", :Item
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Item"
    param :form, :name, :string, :required, "Name"
    param :form, :description, :string, :required, "Description"
    param :form, :price, :decimal, :required, "Price"
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Item"
    param :path, :id, :integer, :required, "Item Id"
    param :form, :name, :string, :optional, "Name"
    param :form, :description, :string, :optional, "Description"
    param :form, :price, :decimal, :optional, "Price"
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User item"
    param :path, :id, :integer, :optional, "Item Id"
    response :unauthorized
    response :not_found
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

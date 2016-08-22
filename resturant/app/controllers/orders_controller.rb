class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  before_action :authenticate_request

  swagger_model :Item do
    description "A Item object"
    property :id, :integer, :required, "Item Id"
  end

  swagger_model :Items do
    description "Items"
    property :items, :array, :required, "A list of items", { "items" => { "$ref" => "Item" } }
  end

  swagger_controller :orders, 'Orders'

  swagger_api :index do
    summary 'Returns all orders'
    notes "This lists all the orders"
    response :requested_range_not_satisfiable
  end

  swagger_api :show do
    summary "Fetches a single Order"
    param :path, :id, :integer, :optional, "Order Id"
    response :ok, "Success", :Item
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Order"
    param :form, :amount, :integer, :required, "The amount of order"
    param :form, :items_id, :array, :required, "The items id to add"
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Order"
    param :path, :id, :integer, :required, "Order Id"
    param :form, :amount, :integer, :optional, "The amount of order"
    param :form, :items_id, :array, :optional, "The items id to add"
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Order"
    param :path, :id, :integer, :optional, "Order Id"
    response :unauthorized
    response :not_found
  end

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:amount, :user_id, :item_ids => [])
    end
end

class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :update, :destroy]
  before_action :authenticate_request, only: [:create, :update, :destroy]
  before_action :authorize_employee_request, only: [:create, :update, :destroy]

  swagger_model :Item do
    description "A Item object"
    property :id, :integer, :required, "Item Id"
  end

  swagger_model :Items do
    description "Items"
    property :items, :array, :required, "A list of items", { "items" => { "$ref" => "Item" } }
  end

  swagger_controller :items, 'Items'

  swagger_api :index do
    summary 'Returns all menus'
    notes "This lists all the menus"
    response :requested_range_not_satisfiable
  end

  swagger_api :show do
    summary "Fetches a single Menu"
    param :path, :id, :integer, :optional, "Menu Id"
    response :ok, "Success", :Item
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Menu"
    param :form, :types, :string, :required, "Type such as 'breakfast','lunch','dinner'"
    param :form, :items_id, :array, :optional, "The items id to add"
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Item"
    param :path, :id, :integer, :required, "Item Id"
    param :form, :types, :string, :optional, "Type such as 'breakfast','lunch','dinner'"
    param :form, :items_id, :array, :optional, "The items id to add"
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User item"
    param :path, :id, :integer, :optional, "Menu Id"
    response :unauthorized
    response :not_found
  end


  # GET /menus
  def index
    @menus = Menu.all

    render json: @menus
  end

  # GET /menus/1
  def show
    render json: @menu
  end

  # POST /menus
  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      render json: @menu, status: :created, location: @menu
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menus/1
  def update
    if @menu.update(menu_params)
      render json: @menu
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  # DELETE /menus/1
  def destroy
    @menu.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def menu_params
      params.require(:menu).permit(:type, :item_ids => [])
    end
end

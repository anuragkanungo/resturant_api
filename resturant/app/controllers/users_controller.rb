class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_request, only: [:index, :create, :show, :update, :destroy]
  before_action :authorize_employee_request, only: [:index, :show]
  before_action :authorize_admin_request, only: [:delete]

  swagger_controller :users, "User Management"

  swagger_api :index do
    summary "Fetches all User items"
    notes "This lists all the active users"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end

  swagger_api :show do
    summary "Fetches a single User item"
    param :path, :id, :integer, :optional, "User Id"
    response :ok, "Success", :User
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new User"
    param :form, "user[name]", :string, :required, "Name"
    param :form, "user[address]", :string, :required, "Address"
    param :form, "user[phone]", :string, :required, "Phone"
    param :form, "user[email]", :string, :required, "Email address"
    param :form, "user[password]", :string, :required, "Password"
    param_list :form, "user[role]", :string, :required, "Role  [ 'admin', 'manager', 'customer' ]"
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing User"
    param :path, :id, :integer, :required, "User Id"
    param :form, "user[name]", :string, :optional, "Name"
    param :form, "user[address]", :string, :optional, "Address"
    param :form, "user[phone]", :string, :optional, "Phone"
    param :form, "user[email]", :string, :optional, "Email address"
    param :form, "user[password]", :string, :optional, "Password"
    param_list :form, "user[role]", :string, :optional, "Role  [ 'admin', 'manager', 'customer' ]"
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User item"
    param :path, :id, :integer, :required, "User Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :authenticate do
    summary "Logs in a User"
    param :form, :email, :string, :required, "Email address"
    param :form, :password, :string, :required, "Password"
    response :unauthorized
    response :not_found
    response :not_acceptable
  end


swagger_controller :user_orders, "User Orders"

swagger_api :index do
    summary "Fetches all UserOrder items"
    param :path, :user_id, :integer, :required, "User Id"
    param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable
    response :requested_range_not_satisfiable
  end




  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    if @current_user
      if @current_user.role != "admin" and (user_params["role"] == "admin" or user_params["role"] == "manager")
        render json: { error: "unauthorized" }, status: :unauthorized
      else
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
    else
        print user_params["role"]
        if user_params["role"] == "admin" or user_params["role"] == "manager"
          render json: { error: "unauthorized" }, status: :unauthorized
        else
          @user = User.new(user_params)
          if @user.save
            render json: @user, status: :created, location: @user
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end
    end
  end

  # PATCH/PUT /users/1
  def update
    if @current_user
      if @current_user == @user or @current_user.role == "admin"
        if @current_user.role != "admin" and (user_params["role"] == "admin" or user_params["role"] == "manager")
          render json: { error: "unauthorized" }, status: :unauthorized
        else
          if @user.update(user_params)
            render json: @user
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end
      else
        render json: { error: "unauthorized" }, status: :unauthorized
      end
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {}).permit(:name, :address, :phone, :email, :password, :role)
    end
end

class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthenticateApiRequest.call(request.headers).result
    render json: { error: 'Authentication Token Wrong/Missing' }, status: 401 unless @current_user
  end

  def authorize_admin_request
    render json: { error: 'Not Authorzied' }, status: 401 unless @current_user.role == "admin"
  end

  def authorize_employee_request
    render json: { error: 'Not Authorzied' }, status: 401 unless (@current_user.role == "admin" or @current_user.role == "manager")
  end

  class << self
    Swagger::Docs::Generator::set_real_methods

    def inherited(subclass)
      super
      subclass.class_eval do
        setup_basic_api_documentation
      end
    end

    private
    def setup_basic_api_documentation
      [:index, :show, :create, :update, :destroy].each do |api_action|
        swagger_api api_action do
          param :header, 'auth_token', :string, :optional, 'Authentication token'
        end
      end
    end
  end

end

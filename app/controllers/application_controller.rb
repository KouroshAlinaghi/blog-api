class ApplicationController < ActionController::API
  before_action :authenticate_token

  def authenticate_token()
    code = request.headers["HTTP_AUTHORIZATION"]
    auth = Auth.find_by_code(code)
    @user_signed_in= !!auth
    @current_user = auth.author if @user_signed_in
  end
end

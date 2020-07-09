class SessionsController < ApplicationController
  require 'securerandom'

  before_action :ensure_signed_in, only: [:destroy]
  before_action :ensure_not_signed_in, only: [:create]

  def create
    @author = Author.find_by_email(params[:email])
    if @author.authenticate(params[:password])
      code = SecureRandom.urlsafe_base64(64)
      @auth = @author.auths.new(code: code)
      if @auth.save
        render json: {successfull: true, code: code}
      else
        render json: {successfull: false, errors: @auth.errors}
      end
    else
        render json: {successfull: false, errors: "Invalid Credentials"}
    end
  end

  def destroy
    code = request.headers["HTTP_AUTHORIZATION"]
    @auth = Auth.find_by_code(code)

    if @auth.destroy
      render json: {successfull: true}
    else
      render json: {successfull: false, errors: @auth.errors}
    end
  end

  protected

  def author_params 
    params.permit(:email, :password)
  end

  def ensure_signed_in
    render json: {successfull: false, errors: ["Unauthorizated"]} unless @user_signed_in
  end

  def ensure_not_signed_in
    render json: {successfull: false, errors: ["you should not be signed in"]} if @user_signed_in
  end
end

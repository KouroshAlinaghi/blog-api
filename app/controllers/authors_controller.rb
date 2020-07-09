class AuthorsController < ApplicationController

  before_action :ensure_signed_in, only: [:destroy, :dashboard, :update, :create]

  def create
    @author = Author.new(author_params)
    if @author.save
      render json: {successfull: true}
    else
      render json: {successfull: false, errors: @author.errors}
    end
  end

  def dashboard
    render json: {successfull: true, user: @current_user}
  end

  def update
    puts @user_signed_in
    if @current_user.update(author_update_params)
      render json: {successfull: true}
    else
      render json: {successfull: false, errors: @current_user.errors}
    end
  end

  def destroy
    if @current_user.destroy
      render json: {successfull: true}
    else
      render json: {successfull: false, errors: @author.errors}
    end
  end

  protected

  def author_params
    params.require(:author).permit(:email, :password, :password_confirmation, :full_name)
  end

  def author_update_params
    params.require(:author).permit(:full_name)
  end

  def ensure_signed_in
    render json: {successfull: false, errors: ["Unauthorized"]} unless @user_signed_in
  end
end

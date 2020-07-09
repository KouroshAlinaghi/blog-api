class AuthorsController < ApplicationController

  before_action :ensure_signed_in, only: [:destroy, :dashboard, :update]
  before_action :ensure_not_signed_in, only: [:create]

  def create
    @author = Author.new(author_params)
    if @author.save
      render json: {successfull: true}
    else
      render json: {successfull: false, errors: @author.errors}
    end
  end

  def dashboard
    render json: @current_user
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
    render json: {successfull: false, errors: ["Unauthorizated"]} unless @user_signed_in
  end

  def ensure_not_signed_in
    render json: {successfull: false, errors: ["you should not be signed in"]} if @user_signed_in
  end
end

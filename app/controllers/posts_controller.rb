class PostsController < ApplicationController

  before_action :ensure_signed_in, only: [:create, :destroy, :update]

  def index
    @posts = Post.filter(params.slice(:q, :author, :order_by))
    render json: {successfull: true, posts: @posts}
  end

  def show
    @post = Post.find(params[:id])
    @post.inc_visit_count()
    render json: {successfull: true, post: @post}
  end

  def create
    @post = @current_user.posts.new(post_params)
    if @post.save
      render json: {successfull: true}
    else
      render json: {successfull: false, errors: @post.errors}
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: {successfull: true}
    else
      render json: {successfull: false, errors: @post.errors}
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: {successfull: true}
    else
      render json: {successfull: false, errors: @post.errors}
    end
  end

  protected

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def ensure_signed_in
    render json: {successfull: false, errors: ["Unauthorized"]} unless @user_signed_in
  end
end

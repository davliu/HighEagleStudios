class PostsController < ApplicationController
  layout 'blogger'
  before_filter :signed_in_user
  before_filter :same_user, only: :destroy

  def new
    @post = current_user.posts.build
  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = 'Post saved'
      redirect_to posts_path
    else
      flash[:notice] = 'Post could not be saved'
      redirect_to posts_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = 'Blog post updated'
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
    def same_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to posts_path if @post.nil?
    end
end

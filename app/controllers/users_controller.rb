class UsersController < ApplicationController
  before_filter :signed_in_user
  before_filter :has_admin, only: [:new, :create]
  before_filter :same_user, only: [:edit, :update]

  layout 'blogger'

  def show
    @user = User.find(params['id'])
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = 'User updated'
      sign_in @user
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      flash[:success] = 'User created. You can now create/edit blog entries.'
      redirect_to users_path
    else
      render 'new'
    end
  end

  private
    def same_user
      @user = User.find(params[:id])
      redirect_to users_path, notice: "You can only edit your own profile" unless current_user?(@user)
    end
end

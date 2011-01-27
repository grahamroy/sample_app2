class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index
    @title = "All Users"
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    if signed_in?
      redirect_to(root_path)
    else
      @user = User.new
      @title = "Sign Up"
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def create
    if signed_in?
      redirect_to(root_path)
    else
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the sample app!"
        redirect_to @user
      else
        @title = "Sign up"
        @user.password = ''
        @user.password_confirmation = ''
        render 'new'
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user?(@user)
      flash[:success] = "Can't Delete Yourself Muppet"
      redirect_to users_path
      else
      @user.destroy
      flash[:success] = "User Destroyed"
      redirect_to users_path
      end
    end

  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end




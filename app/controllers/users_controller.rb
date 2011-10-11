class UsersController < ApplicationController

  before_filter :authenticate,  :only => [ :index, :edit, :update ]
  before_filter :correct_user,  :only => [ :edit, :update ]
  before_filter :admin_user,    :only => :destroy 
  before_filter :no_need_to_see,    :only => [ :new, :create ]
  before_filter :protect_from_admin_destroying_self, :only => [ :destroy ]


  def new
    @title = "Sign up"
    @user  = User.new
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page]) 
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(:page => params[:page])
  end

  def create

    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      @title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])
    @title = "Edit user"
  end


  def update 
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    flash[:success] = "User was destroyed."
    redirect_to users_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def no_need_to_see 
      redirect_to(root_path) if signed_in?
    end

    def protect_from_admin_destroying_self
      user = User.find(params[:id])
      user.admin? ? redirect_to(root_path) : user.destroy
    end

end



# user_controller
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :admin_user,     only: :destroy
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def show
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "User #{params[:id]} not found"
      redirect_to users_path, notice: 'User not found'
    end
  end
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user, notice: 'User was successfully created.'
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to new_user_url, notice: 'User wasy destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :user, :full_name, :birthday,
      :email, :adress, :city, :country,
      :password, :password_confirmation,
      :latitude, :longitude, :avatar,
      :admin, :moderator
    )
  end

  # Before filters

  def signed_in_user
    redirect_to signin_url, notice: 'Please sign in.' unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

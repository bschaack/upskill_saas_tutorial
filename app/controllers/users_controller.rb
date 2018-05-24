class UsersController < ApplicationController
  # Secures users so you have to be logged in to view
  before_action :authenticate_user!
  
  def index
    # Instead of User.all use User.includes so only one query is sent;
    # Otherwise each user is a query loading the server up when lots of users
    @users = User.includes(:profile)
  end
  
  # GET to /users/:id
  def show
    @user = User.find( params[:id] )
  end
    
end
class UsersController < ApplicationController
  # Secures users so you have to be logged in to view
  before_action :authenticate_user!
  
  def index
    
  end
  
  # GET to /users/:id
  def show
    @user = User.find( params[:id] )
  end
    
end
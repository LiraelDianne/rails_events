class UsersController < ApplicationController
	def landing_page
		@user = User.new
	end

	def login
		@user = User.new(user_params)
	    if user.authenticate(params[:password])
	      session[:user_id] = user.id
	      redirect_to events_url 
	    else 
	      flash[:login_error] = "Invalid email and password combination."
	      redirect_to root_url
	    end		
	end

	def logout
		session.destroy
    	redirect_to root_url
  	end

	def create 
		@user = User.new(user_params)
    	if @user.valid? 
      		@user.save
      		session[:user_id] = @user.id
      		redirect_to events_url
    	else 
      		flash[:errors] = @user.errors.full_messages
      		redirect_to root_url
    	end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
    	if @user.update(user_params)
      		redirect_to action: 'show', id: @user.id 
    	else
      		flash[:errors] = @user.errors.full_messages
      		redirect_to edit_user_url
    	end
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :location, :state, :email, :password, :password_confirmation)
	end
end

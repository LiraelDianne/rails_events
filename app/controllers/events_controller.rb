class EventsController < ApplicationController
	def index
		@user = User.find(session[:user_id])
		@inStateEvents = Event.where(state: @user.state).take(3)
		@otherEvents = Event.where.not(state: @user.state).take(2)
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		user = User.find(session[:user_id])
		if @event.valid?
			user.events.create(event_params)
		else
			flash[:errors] = @event.errors
		end
		redirect_to events_url
	end

	def show
		@event = Event.find(params[:id])
	end

	def edit 
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
      		redirect_to event_url
    	else
      		flash[:errors] = @event.errors
      		redirect_to edit_event_url
    	end
	end

	def join
		event = Event.find(params[:id])
		user = User.find(session[:user_id])
		unless Attended.where(user: user, event: event).take
			Attended.create(user: user, event: event)
		end
		redirect_to events_url

	def leave 
		event = Event.find(params[:id])
		user = User.find(session[:user_id])
		Attended.where(user: user, event: event).take 
		Attended.destroy
		redirect_to events_url

	def delete
		Event.destroy(params[:id])
		redirect_to events_url
	end

	private
	def event_params
		params.require(:event).permit(:name, :date, :location, :state)
end

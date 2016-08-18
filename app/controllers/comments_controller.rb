class CommentsController < ApplicationController
  def create
  	comment = Comment.new(comment_params)
    event = Event.find(params[:event_id])
  	if comment.valid?
  		Event.comments.create(comment_params, user: User.find(session[:user_id]))
  		redirect_to '/events/'+params[:comment][:event]
  	else
  		flash[:comment_error] = comment.errors.full_messages
  	end
  		redirect_to '/events/'+params[:comment][:event]
  end
  private
  def comment_params
  	params.require(:comment).permit(:content)
  end
end

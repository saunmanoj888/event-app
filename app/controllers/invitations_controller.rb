class InvitationsController < ApplicationController
	before_action :require_login
	before_action :find_event
	before_action :validate_user_email, only: [:create]
	before_action :validate_redundant_invitation, only: [:create]

	def new
		@invitation = @event.invitations.new
	end

	def create
		@invitation = @event.invitations.new(invitation_params)
    if @invitation.save
      flash[:success] = "Invitation was sent successfully"
      redirect_to event_path(@event)
    else
      render 'new'
    end
	end

	private

	def invitation_params
    params.require(:invitation).permit(:email)
  end

	def find_event
		@event = Event.find(params[:event_id]).reload
	end

	def validate_user_email
    if params[:invitation][:email] == current_user.email
      flash[:danger] = "You cannot send invitation to self"
      redirect_to event_path(@event)
    end
  end

  def validate_redundant_invitation
  	if @event.invitations.pluck(:email).include?(params[:invitation][:email])
  		flash[:danger] = "You have already sent invitation to this User"
  		redirect_to event_path(@event)
  	end
  end

end
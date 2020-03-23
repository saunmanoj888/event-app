class DashboardController < ApplicationController

	before_action :require_login

	def home
		@events = Event.joins(:invitations)
			.where('invitations.email' => current_user.email, 'invitations.status' => 'accepted')
	end

	def invitation
		@invitations = Invitation.where(email: current_user.email).not_accepted.reload
	end

	def accept_invitation
		Invitation.find(params[:id]).accept!
		redirect_to invitations_path
	end

	def reject_invitation
		Invitation.find(params[:id]).reject!
		redirect_to invitations_path
	end

end
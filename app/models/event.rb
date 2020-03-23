class Event < ApplicationRecord

	validates :name, :description, :start_time, :end_time, presence: true

	has_many :invitations, dependent: :destroy
	belongs_to :user

	def associated_invitation
		invitations.where(event_id: id).last
	end

	def event_duration
		time_diff = end_time - start_time
		if (time_diff / 1.hour) > 1
			"#{(time_diff / 1.hour)} Hrs"
		else
			"#{(time_diff / 1.minute)} Minutes"
		end
	end

end
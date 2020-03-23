class Invitation < ApplicationRecord
	include AASM

	validates :email, presence: true
	validate :validate_invitation_email, on: :create

	belongs_to :event

	scope :not_accepted, -> { where.not(status: 'accepted') }

	aasm do
		state :pending, initial: true
		state :accepted, :rejected

		event :accept do
      transitions from: [:pending, :rejected], to: :accepted, after: Proc.new { accept_invitation }
    end

    event :reject do
      transitions from: [:pending, :accepted], to: :rejected, after: Proc.new { reject_invitation }
    end
  end

	private

	def validate_invitation_email
		unless User.all.pluck(:email).include?(email)
			errors.add(:base, 'User with this email does not exist')
		end
	end

	def accept_invitation
		update_column(:status, 'accepted')
	end

	def reject_invitation
		update_column(:status, 'rejected')
	end
end
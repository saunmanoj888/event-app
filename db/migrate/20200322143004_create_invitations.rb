class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
    	t.belongs_to :event
    	t.string :email
    	t.string :status, default: 'pending'
    end
  end
end

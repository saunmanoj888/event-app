class AddColumnAasmStateToInvitation < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :aasm_state, :string
  end
end

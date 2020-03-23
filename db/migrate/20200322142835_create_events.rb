class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
    	t.belongs_to :user
    	t.string :name
    	t.text :description
    	t.datetime :start_time
    	t.datetime :end_time
    end
  end
end

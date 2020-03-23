class EventsController < ApplicationController

	before_action :require_login
  before_action :set_event, only: [:edit, :update, :show, :destroy]

	def index
		@events = current_user.reload.events.paginate(page: params[:page], per_page: 5)
	end

	def new
		@event = current_user.events.new
	end

	def create
    @event = current_user.events.new(event_params)
    if @event.save
      flash[:success] = "Event was successfully created"
      redirect_to events_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Event was successfully updated"
      redirect_to events_path
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    flash[:danger] = "Event was successfully deleted"
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time)
  end

  def set_event
    @event = Event.find(params[:id])  
  end
end
class EventsController < ApplicationController

  def index
    @events = Event.all
    @eventsToday = []
    @eventsTomorrow = []
    @events.each do |event|
      if event.day == Date.today.to_s
        @eventsToday << event
      elsif event.day == (Date.today+1).to_s
        @eventsTomorrow << event
      end
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.save
    redirect_to :controller => 'events', :action => 'index'
  end

  def edit
    @event = Event.find(params[:id])
  end

  def attending
    @event = Event.find(params[:id])
    type = params[:type]
    if type == "attending" && @event.space != 0
      current_user.attending << @event
      @event.space = @event.space - 1
      @event.save
      AdminMailer.new_attending(@event.user, current_user).deliver_now
      redirect_to :back, notice: "You've joined the group. Your number will be sent to #{@event.user.name}"

    else type == "unattending"
      current_user.attending.delete(@event)
      redirect_to :back, notice: "You've removed yourself from the group"
    end
  end



end

def event_params
  params.require(:event).permit(:area, :level, :plan, :meeting, :space, :day)
end

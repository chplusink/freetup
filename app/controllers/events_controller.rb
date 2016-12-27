class EventsController < ApplicationController
  before_action :set_events, only: [:index, :edit]

  private

  def set_events
    @events = Event.all
  end

  def event_params
    params.require(:event).permit(:title, :description)
  end

end

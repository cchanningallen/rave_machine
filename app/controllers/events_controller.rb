class EventsController < ApplicationController
  expose(:events) { Event.where('date >= ?', Date.today).order('date ASC') }
  expose(:event, attributes: :event_params)

  def create
    if event.save
      flash[:notice] = "Event successfully created!"
      redirect_to events_path
    else
      flash[:errors] = event.errors.full_messages
      render :new
    end
  end

  def destroy
    if event.destroy
      flash[:notice] = "BOOM! Event destroyed."
    else
      flash[:errors] = event.errors.full_messages
    end

    redirect_to events_path
  end

  def poll_events
    EventPoller.poll_sources_and_create_events
    flash[:notice] = "All the events be got."
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :date,
      :time,
      :artists,
      :headliner,
      :location,
      :description,
      :event_link,
      :ticket_link
    )
  end
end

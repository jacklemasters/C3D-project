class EventsController < ApplicationController
  def index
    @events = Event.includes(:place).all # eager loading of places
  end

  def show
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @event.as_json(include: :guests) }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event created"
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated"
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "Event deleted"
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :place_id, :starts_at, :ends_at)
  end
end

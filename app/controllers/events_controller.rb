class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.includes(:place) # eager loading of places
    
    @sort_by        = params[:sort_by]&.to_sym || :starts_at
    @sort_direction = params[:direction] == 'desc' ? :desc : :asc
    
    sort_columns = {
      name:      'name',
      place:     'places.name',
      starts_at: 'starts_at',
      guests:    'guests_count'
    }
    
    if sort_columns.key?(@sort_by)
      column  = sort_columns[@sort_by]
      @events = @events.order(column => @sort_direction)
    else
      @events = @events.order(starts_at: :asc) # default sort by start date
    end
  end

  def show    
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
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated"
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event deleted"
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :place_id, :starts_at, :ends_at)
  end
end

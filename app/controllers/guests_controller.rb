class GuestsController < ApplicationController
  before_action :set_event, only: [:create]
  before_action :set_guest, only: [:destroy]

  def create
    @guest = @event.guests.build(guest_params)

    respond_to do |format|
      if @guest.save
        format.html { redirect_to @event, notice: "Guest was successfully added to the event." }
        format.json { render json: @guest, status: :created }
      else
        format.html { redirect_to @event, alert: @guest.errors.full_messages.join(", ") }
        format.json { render json: { errors: @guest.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = @guest.event
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to @event, notice: "Guest was successfully removed from the event." }
      format.json { head :no_content }
    end
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_guest
    @guest = Guest.find(params[:id])
  end

  def guest_params
    params.require(:guest).permit(:name, :email)
  end
end

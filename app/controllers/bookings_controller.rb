class BookingsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @screening = Screening.find(params[:id])
    @booking = current_user.bookings.build(screening: @screening)
    set_seat_options
  end

  def create
    @booking = current_user.bookings.build(booking_params)

    if @booking.save
      flash[:success] = 'Successfully booked'
      redirect_to root_url
    else
      @screening = Screening.find(params[:booking][:screening_id])
      set_seat_options
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:screening_id, :seat_id)
  end

  def set_seat_options
    booked_seats = Seat.joins(:bookings).where('bookings.screening_id': params[:id])
    @seat_options = Seat.where(cinema: @screening.cinema).map do |seat|
      ["#{seat.cinema.name}-#{seat.id}", seat.id]
    end
  end
end

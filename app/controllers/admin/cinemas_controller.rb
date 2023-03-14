class Admin::CinemasController < Admin::AdminController
  before_action :ensure_logged_in, only: %i[new create]
  before_action :set_default_seat_count
  before_action :ensure_admin, only: %i[new create]

  def new
    @cinema = Cinema.new
  end

  def index
    @cinema = Cinema.all
  end

  def show
    @cinema = Cinema.find(params[:id])
    @bookings = @cinema.bookings
  end

  def create
    @cinema = Cinema.new(cinema_params)
    
    if @cinema.save
      Cinema::DEFAULT_SEAT_COUNT.times do
        @cinema.seats.create
      end
      
      flash[:success] = 'Cinema created'
      redirect_to admin_root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def cinema_params
    params.require(:cinema).permit(:name)
  end
  
  def set_default_seat_count
    @default_seat_count = Cinema::DEFAULT_SEAT_COUNT
  end
end

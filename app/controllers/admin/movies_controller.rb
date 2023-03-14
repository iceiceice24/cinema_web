class Admin::MoviesController < Admin::AdminController
  before_action :ensure_logged_in
  before_action :ensure_admin
  
  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.new(movie_params)
    
    if @movie.save
      flash[:success] = 'Movie created'
      redirect_to admin_root_url
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def movie_params
    params.require(:movie).permit(:title)
  end
end

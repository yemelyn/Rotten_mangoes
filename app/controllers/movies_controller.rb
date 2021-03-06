class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order(:title)
    @movies = @movies.search(params[:search]) unless params[:search].blank?
    @movies = @movies.duration_search(params[:minimum_duration], params[:maximum_duration]) unless (params[:minimum_duration].blank? || params[:maximum_duration].blank?)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(:title, :director, :runtime_in_minutes, :poster_image_url, :description, :release_date, :poster)
  end
end

class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    redirect_to movies_path, notice: "添加电影成功！"
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    redirect_to movies_path, notice: "编辑电影成功！"
  end

  private

  def movie_params
    params.require(:movie).permit(:filmname, :introduction)
  end
end

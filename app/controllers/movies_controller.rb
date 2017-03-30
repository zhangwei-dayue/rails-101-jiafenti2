class MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :show, :update, :destroy]
  before_action :find_movie_check_permission , only: [:edit, :update, :destroy]
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    if @movie.save
      redirect_to movies_path, notice: "添加电影成功！"
    else
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "编辑电影成功！"
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, alert: "删除电影成功！"
  end

  private

  def find_movie_check_permission
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to movies_path, alert: "你没有权限进行操作！"
    end
  end

  def movie_params
    params.require(:movie).permit(:filmname, :introduction)
  end
end

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
    @reviews = @movie.reviews.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if @movie.save
      current_user.favrite!(@movie)
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

  def favrite
    @movie = Movie.find(params[:id])
    if !current_user.is_member_of?(@movie)
      current_user.favrite!(@movie)
      flash[:notice] = "收藏电影成功！"
    else
      flash[:warning] = "你已经收藏过电影了！"
    end
    redirect_to movie_path(@movie)
  end

  def cancel
    @movie = Movie.find(params[:id])
    if current_user.is_member_of?(@movie)
      current_user.cancel!(@movie)
      flash[:notice] = "已成功取消收藏电影！"
    else
      flash[:warning] = "你没有收藏过电影,怎么取消?"
    end
    redirect_to movie_path(@movie)
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

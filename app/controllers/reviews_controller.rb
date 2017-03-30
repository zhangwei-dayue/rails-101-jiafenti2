class ReviewsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user
    if @review.save
      redirect_to movie_path(@movie), notice: "添加影评成功！"
    else
      render :new
    end
  end

  def review_params
    params.require(:review).permit(:content)
  end
end

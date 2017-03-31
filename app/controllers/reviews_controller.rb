class ReviewsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  before_action :find_reviews_check_permission , :only => [:new, :edit, :create, :update, :destroy]
  def new
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end


  def create
    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user
    if @review.save
      redirect_to movie_path(@movie), notice: "添加影评成功！"
    else
      render :new
    end
  end

  def update
    @review = Review.find(params[:id])
    if current_user != @review.user
      redirect_to account_reviews_path(@movie), alert: "你没有权限进行操作！"
    else
      @review.update(review_params)
      redirect_to account_reviews_path(@movie), notice: "编辑成功！"
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    if current_user != @review.user
      redirect_to account_reviews_path(@movie), alert: "你没有权限进行操作！"
    else
      @review.destroy
      redirect_to account_reviews_path(@movie), alert: "删除成功！"
    end
  end

  private

  def find_reviews_check_permission
    @movie = Movie.find(params[:movie_id])
    if current_user.is_member_of?(@movie)
    else
      redirect_to account_reviews_path(@movie), alert: "你没有权限进行操作！"
    end
  end


  def review_params
    params.require(:review).permit(:content)
  end
end

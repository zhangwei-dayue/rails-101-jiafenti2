class MoviesController < ApplicationController
  def index
    @moives = Movie.all
  end
end

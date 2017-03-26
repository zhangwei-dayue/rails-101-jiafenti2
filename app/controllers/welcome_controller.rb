class WelcomeController < ApplicationController
  def index
    flash[:notice] = "欢迎来到张伟影评网"
  end
end

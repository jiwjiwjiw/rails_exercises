class IdeasController < ApplicationController
  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
  end

  def new
  end

  def create
  end
end

class IdeasController < ApplicationController
  def index
    @search_term = params[:q]
  end
end

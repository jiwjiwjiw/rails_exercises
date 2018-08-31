class IdeasController < ApplicationController
  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
    @ideas = Idea.search(@search_term)
  end

  def new
  end

  def create
    idea = Idea.new(params)
    idea.save!
    redirect_to(ideas_index_path)
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def update
    idea = Idea.find(params[:id])
    idea.update(params)
    redirect_to(account_ideas_path)
  end

  private

  def idea_params
    # params.permit(:title, :description, :photo_url, :done_count, :name_of_user)
  end

end

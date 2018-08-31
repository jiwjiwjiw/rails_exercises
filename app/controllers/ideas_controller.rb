class IdeasController < ApplicationController
  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
    @ideas = Idea.search(@search_term)
  end

  def new
  end

  def create
    idea = Idea.new(ideas_params)
    idea.save!
    redirect_to(ideas_path)
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def update
    idea = Idea.find(params[:id])
    idea.update(idea_resource_params)
    redirect_to(account_ideas_path)
  end

  private

  def ideas_params
    params.permit(:title, :description, :photo_url, :done_count)
  end

  def idea_resource_params
    params.require(:idea).permit(:title, :description, :photo_url, :done_count)
  end

end

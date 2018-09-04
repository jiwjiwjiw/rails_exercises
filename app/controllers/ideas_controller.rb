class IdeasController < ApplicationController
  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
    @ideas = Idea.search(@search_term)
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_resource_params
    @idea.user = User.find session[:user_id]
    if @idea.save
      redirect_to ideas_path
    else
      render 'new'
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def show
    @idea = Idea.find(params[:id])
    @user = nil
    if session[:user_id].present?
      @user = User.find session[:user_id]
    end
    @comment = Comment.new
    @logged = session[:user_id].present?
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_resource_params)
      redirect_to(account_ideas_path)
    else
      render 'edit'
    end
  end

  private

  def idea_resource_params
    params.require(:idea).permit(:title, :description, :photo_url, :done_count)
  end

end

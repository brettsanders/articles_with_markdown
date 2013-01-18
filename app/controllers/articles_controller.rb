class ArticlesController < ApplicationController

  def index
    if params[:search].blank?
      @search_results = []
    else
      @search = Article.search do
        fulltext params[:search]
      end
      @search_results = @search.results

    end
    @articles = Article.all
  end

  # def index
  #   @search = Article.search do
  #     fulltext params[:search]
  #   end
  #   @articles = Article.all
  #   @search_results = @search.results

  #   @user = Cameraplus::API::User.find("brettrsanders")

  # end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to @article, :notice => "Successfully created article."
    else
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to @article, :notice  => "Successfully updated article."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url, :notice => "Successfully destroyed article."
  end
end

class ArticlesController < ApplicationController

  #Runs the method before anything else
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles  = Article.paginate(page: params[:page], per_page: 5).order("created_at DESC")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] = "Article was created succesfully!"
      redirect_to @article 
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated succesfully!"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  def find_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description)
  end

end
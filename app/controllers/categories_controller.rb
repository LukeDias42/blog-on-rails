class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end
   
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "The category has been saved successfully"
      redirect_to @category
    else
      render 'new'
    end
  end

  def index
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
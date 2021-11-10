class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else 
      render :new
    end  
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])  
  end
  private

  def recipe_params
    params.require(:recipe).permit(:title, :description,
     :required_appliances, :ingredient_list, :instructions)
  end
end

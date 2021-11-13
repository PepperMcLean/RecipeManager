class RecipesController < ApplicationController
  helper_method :average_rating
  before_action :redirect_if_not_logged_in
  before_action :recipe_author_check, only: [:edit, :update]
  before_action :set_recipe, only: [:show, :edit, :update]

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
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @recipes = @user.recipes
    else
      @error = "That user doesn't exist" if params[:user_id]
      @recipes = Recipe.all
    end
  end

  def show
  end

  def edit 
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path
    else
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description,
     :required_appliances, :ingredient_list, :instructions)
  end

  def recipe_author_check
    set_recipe
    if @recipe.user != current_user
      redirect_to recipes_path 
    end
  end

  def average_rating(recipe)
    count = 0.0
    total = 0.0
    recipe.reviews.each do |t|
      total += t.rating
      count += 1
    end
    x = (total/count).round(2)
    if x.nan?
      return "Unreviewed"
    else
      return x
    end
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

end

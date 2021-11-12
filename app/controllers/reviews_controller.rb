class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :review_author_check, only: [:edit, :update]

  def new
    if params[:recipe_id] && @recipe = Recipe.find_by_id(params[:recipe_id])
      @review = @recipe.reviews.build
    else
      @error = "That recipe doesn't exist" if params[:recipe_id]
      @review = Review.new
    end
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to recipe_path(@review.recipe_id)
    else 
      render :new
    end  
  end

  def index
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @reviews = @user.reviews
    else
      @error = "That user doesn't exist" if params[:user_id]
      @reviews = Review.all
    end
  end

  def show
    @review = Review.find_by(id: params[:id])  
  end
  
  def edit
    @review = Review.find_by(id: params[:id])  
  end

  def update
    @review = Review.find_by(id: params[:id])
    if @review.update(review_params)
      redirect_to review_path
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :title, :recipe_id, :rating)
  end

  def review_author_check
    @review = Review.find_by(id: params[:id])
    if @review.user != current_user
      redirect_to reviews_path 
    end
  end
end

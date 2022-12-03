class RecipesController < ApplicationController
    
    before_action :authorize


    def index
        user = User.find_by(id: session[:user_id])
        recipes = Recipe.all
        render json: recipes, status: :created
    end

    def create
        user = User.find_by(id: session[:user_id]) 
        recipe = Recipe.create(recipe_params)
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
        end
    end


    private
    def authorize
        return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
        params.permit(:id, :user_id, :title, :instructions, :minutes_to_complete)
    end
end

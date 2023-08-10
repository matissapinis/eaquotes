class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      #### @quotes = @user.quotes.paginate(page: params[:page]).order(created_at: :desc)
      @quotes = @user.quotes.order(created_at: :desc).paginate(page: params[:quotes_page], per_page: 2)

      #### @favorite_quotes = @user.favorites.paginate(page: params[:page]).order(created_at: :desc)
      #### @favorite_quotes = @user.favorited_quotes.paginate(page: params[:page]).order(created_at: :desc)
      
      #### @favorite_quotes = @user.favorited_quotes.order(created_at: :desc).paginate(page: params[:page])
      @favorite_quotes = @user.favorited_quotes.order(created_at: :desc).paginate(page: params[:favorites_page], per_page: 2)
    end
end
  
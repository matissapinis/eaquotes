class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      @quotes = @user.quotes.paginate(page: params[:page]).order(created_at: :desc)
    end
end
  
class QuotesController < ApplicationController
    before_action :set_quote, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    ## Make sure that only logged-in users can access their quotes:
    before_action :authenticate_user!, only: [:user_quotes]

    def index
        #### @quotes = Quote.all.order(created_at: :desc)
        ## Paginate the quotes:
        #### @quotes = Quote.paginate(page: params[:page]).order(created_at: :desc)
        @quotes = @user.quotes.order(created_at: :desc).paginate(page: params[:quotes_page], per_page: 2)
    end
  
    def show
    end
  
    def new
      @quote = Quote.new
    end
  
    def create
      @quote = Quote.new(quote_params)
      @quote.user = current_user  # Assign the quote to the Devise current user
      if @quote.save
        flash[:success] = "Quote was successfully created."
        redirect_to @quote
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @quote.update(quote_params)
        redirect_to @quote, notice: 'Quote was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @quote.destroy
      redirect_to quotes_url, notice: 'Quote was successfully destroyed.'
    end
  
    ## Users can see the quotes they've added:
    def user_quotes
        ## Added pagination:
        @user_quotes = current_user.quotes.paginate(page: params[:page]).order(created_at: :desc)
    end      

    def add_favorite
        favorite = current_user.favorites.build(quote_id: params[:id])
        if favorite.save
          redirect_to quotes_path, notice: 'Quote added to favorites!'
        else
          redirect_to quotes_path, alert: 'Something went wrong... *sad panda*'
        end
    end
      
    def remove_favorite
        favorite = current_user.favorites.find_by(quote_id: params[:id])
        favorite.destroy
        redirect_to quotes_path, notice: 'Quote removed from favorites.'
    end      

    ## Paginate and display the user's favorite quotes:
    def user_favorites
        @favorite_quotes = current_user.favorited_quotes.paginate(page: params[:page]).order(created_at: :desc)
    end    

    private
  
    def set_quote
      @quote = Quote.find(params[:id])
    end
  
    def authorize_user!
      unless current_user.admin? || @quote.owned_by?(current_user)
        redirect_to quotes_path, alert: 'You are not authorized to perform this action.'
      end
    end
  
    def quote_params
      params.require(:quote).permit(:content, :attribution, :source, :source_link, :comment)
    end
end
  
class QuotesController < ApplicationController
    before_action :set_quote, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
    #### before_action :authorize_user!, only: [:edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy, :add_topic, :remove_topic]

    ## Make sure that only logged-in users can access their quotes:
    before_action :authenticate_user!, only: [:user_quotes]

    def index
        #### @quotes = Quote.all.order(created_at: :desc)
        ## Paginate the quotes:
        @quotes = Quote.paginate(page: params[:page]).order(created_at: :desc)
    end
  
    def show
    end
  
    def new
      @quote = Quote.new
    end
  
    def create
      @quote = Quote.new(quote_params)
      @quote.user = current_user  ## Assign the quote to the Devise current user.
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
          redirect_to request.referrer ||  quotes_path(page: params[:page]), notice: 'Quote added to favorites!'
        else
          redirect_to request.referrer || quotes_path(page: params[:page]), alert: 'Something went wrong... *sad panda*'
        end
    end
      
    def remove_favorite
        favorite = current_user.favorites.find_by(quote_id: params[:id])
        favorite.destroy
        redirect_to request.referrer || quotes_path(page: params[:page]), notice: 'Quote removed from favorites.'
    end      

    ## Methods to add and remove topics from quotes:
    def add_topic
        @quote = Quote.find(params[:id])
        @quote.add_topic_by_name(params[:topic_name])
        redirect_to edit_quote_path(@quote)
    end
    
    def remove_topic
        @quote = Quote.find(params[:id])
        @quote.remove_topic_by_name(params[:topic_name])
        redirect_to edit_quote_path(@quote)
    end

    ## Methods to handle upvotes and downvotes:
    def upvote
        if @quote.upvoted_by?(current_user)
            @quote.upvoted_users.delete(current_user)
        else
            @quote.upvoted_users << current_user
            @quote.downvoted_users.delete(current_user) ## Ensure user can't both upvote and downvote.
        end
        redirect_to request.referrer || quotes_path(page: params[:page])
    end
      
    def downvote
        if @quote.downvoted_by?(current_user)
            @quote.downvoted_users.delete(current_user)
        else
            @quote.downvoted_users << current_user
            @quote.upvoted_users.delete(current_user) ## Ensure user can't both upvote and downvote.
        end
        redirect_to request.referrer || quotes_path(page: params[:page])
    end    

    def user_favorites
        @user = current_user
        ## Fetch favorited quotes to paginate and display the user's favorite quotes:
        @favorite_quotes = @user.favorited_quotes.paginate(page: params[:page]).order(created_at: :desc)
    
        ## Fetch recently voted quotes:
        all_recently_voted_quotes = Quote.joins("LEFT JOIN upvotes ON upvotes.quote_id = quotes.id")
        .joins("LEFT JOIN downvotes ON downvotes.quote_id = quotes.id")
        .where('upvotes.user_id = ? OR downvotes.user_id = ?', @user.id, @user.id)
        .order(updated_at: :desc)
        .distinct
        .limit(10)

        @recently_voted_quotes = all_recently_voted_quotes.paginate(page: params[:recent_votes_page], per_page: 2)
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
        params.require(:quote).permit(:content, :attribution, :source, :source_link, :comment, :topic_names)
    end    
end
  
class QuotesController < ApplicationController
    before_action :set_quote, only: [:show, :edit, :update, :destroy]
  
    def index
        @quotes = Quote.all.order(created_at: :desc)
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
        #### redirect_to @quote, notice: 'Quote was successfully created.'
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
        @quote = Quote.find(params[:id]) ## Find the quote to be deleted.
        @quote.destroy
        redirect_to quotes_url, notice: 'Quote was successfully destroyed.'
    end
  
    private
  
    def set_quote
      @quote = Quote.find(params[:id])
    end
  
    private

    def quote_params
      params.require(:quote).permit(:content, :attribution, :source, :source_link, :comment)
    end    
  end
  
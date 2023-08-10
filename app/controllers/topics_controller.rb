class TopicsController < ApplicationController
  ## Fetch all topics and display them in the index view:
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end
end

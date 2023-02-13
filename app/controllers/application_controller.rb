require 'pry'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

  get '/reviews/:id' do
    review = Review.find(params[:id])
    review.to_json 
  end 

  delete '/reviews/:id' do 
    # find the review using the ID 
    review = Review.find(params[:id])
    # delete the review 
    review.destroy 
    # send a response with the deleted review as JSON 
    review.to_json 
  end 

  # fetch(`http://localhost:9292/reviews/1`, {
  #   method: "DELETE",
  # });

  post '/reviews' do 
    binding.pry 
    # Access the data in the body of the request
    # Use that data to create a new review in the database
    # Send a response with newly created review as JSON 

end

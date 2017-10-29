class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/:id' do

    @landmark = Landmark.find_by_id(params[:id])

    erb :'landmarks/show'
  end
end

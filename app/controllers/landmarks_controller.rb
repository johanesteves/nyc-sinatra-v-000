class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get  '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.new(params[:landmark])

    if !params[:figure][:name].empty?
      @landmark.figure = Figure.create(params[:figure])
    elsif !params[:title][:name].empty?
      @landmark.titles << Title.create(params[:title])
    end

    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])

    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark  = Landmark.find_by_id(params[:id])
    @landmark.update(params[:landmark])

    if !params[:figure][:name].empty?
      @landmark.figure = Figure.create_or_find_by(params[:figure])
    elsif !params[:title][:name].empty?
      @landmark.titles << Title.create_or_find_by(params[:title])
    end
    @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end



  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/show'
  end
end

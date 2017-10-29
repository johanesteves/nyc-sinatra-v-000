class FiguresController < ApplicationController


  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @figure  = Figure.new(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    elsif !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])

    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure  = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create_or_find_by(params[:landmark])
    elsif !params[:title][:name].empty?
      @figure.titles << Title.create_or_find_by(params[:title])
    end
    @figure.save

    redirect "/figures/#{@figure.id}"
  end


  get '/figures/:id' do

    @figure = Figure.find_by_id(params[:id])

    erb :'figures/show'
  end

end

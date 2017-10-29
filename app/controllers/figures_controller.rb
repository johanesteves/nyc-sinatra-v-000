class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    binding.pry
    @figure  = Figure.new(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark][:name])
    elsif !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title][:name])
    end

    @figure.save

    redirect "/figures/#{@figure.id}"
  end




  get '/figures/:id' do

    @figure = Figure.find_by_id(params[:id])

    erb :'figures/show'
  end

end

class GenreController<ApplicationController

  get '/genres' do
    @genres = Genre.all
    erb :'./genres/index'
  end

  get '/genres/:name' do
    @genre = Genre.find_by_slug(params[:name])
    erb :'./genres/show'
  end




end

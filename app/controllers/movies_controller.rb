class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sort_by]
        session[:sort_by] = params[:sort_by]
        @hilite_column = session[:sort_by]
    end

    if params[:release_date]
        session[:release_date] = params[:release_date]
        @hilite_column = session[:release_date]
    end

    session[:ratings] = params[:ratings] if params[:ratings]
 
    redirect = false
    
    @all_ratings = Movie.all_ratings
    @hilite_column = if session[:sort_by]
                       session[:sort_by]
                     elsif session[:release_date]
                       session[:release_date]
                     end
    
    @checked_ratings = if session[:ratings]
                         session[:ratings].keys
                       else
                         @all_ratings
                       end
                       redirect = true
    if redirect
            redirect_to movies_path(:sort => session[:sort_by], :ratings => session[:ratings])
        end

    @movies = Movie.order(@hilite_column).where(:rating => @checked_ratings)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

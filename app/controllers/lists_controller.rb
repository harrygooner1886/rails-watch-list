class ListsController < ApplicationController
  def index
    # get all the lists from the DB
    @lists = List.all
  end

  def show
    # find the list we want to display
    @list = List.find(params[:id])
  end

  def new
    # instantiate an empty list instance
    @list = List.new
  end

  def create
    # make an instance of a list with the params
    @list = List.new(list_params)
    # try saving it
    if @list.save
      # if it succeeds take them to the show
      redirect_to list_path(@list)
      # if it fails rerender the new page
    else
      render 'new', status: :unprocessable_content
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end

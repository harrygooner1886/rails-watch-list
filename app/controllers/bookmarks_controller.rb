class BookmarksController < ApplicationController
  def new
    # find the list
    @list = List.find(params[:list_id])
    # instantiate an empty bookmark instance
    @bookmark = Bookmark.new
  end

  def create
    # make an instance of bookmark with the params
    @bookmark = Bookmark.new(bookmark_params)
    # find the list
    @list = List.find(params[:list_id])
    # assign that list to the bookmark
    @bookmark.list = @list
    # try saving it
    if @bookmark.save
      # if it successful list show
      redirect_to list_path(@list)
    else
      # if it fails render new
      render 'new', status: :unprocessable_content
    end
  end

  def destroy
    # find the bookmark to delete
    @bookmark = Bookmark.find(params[:id])
    @list = List.find(params[:list_id])

    if @bookmark.destroy
      redirect_to list_path(@list)
    else
      render 'lists/show', status: :unprocessable_content
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end

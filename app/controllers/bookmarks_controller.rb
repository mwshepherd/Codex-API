class BookmarksController < ApplicationController
  before_action :authenticate_user
  before_action :set_bookmark, only: %i[show update destroy]

  def index
    bookmarks = current_user.bookmarks.order(id:'desc').paginate(page: params[:page])
    render json: { bookmarks: bookmarks.as_json(include: [:category, :language]), total_bookmarks: current_user.bookmarks.length, current_user: current_user.username }

      # render json: { bookmarks: bookmarks.as_json(include: [:category, :language], total_bookmarks: current_user.bookmarks.length, current_user: current_user.username }

    # // almost working:
    # render json: { bookmarks: bookmarks.as_json(:include => {:category => {:include => :name}, :language => {:include => :name}}), total_bookmarks: current_user.bookmarks.length, current_user: current_user.username }

  end

  def show
    render json: @bookmark
  end

  def create
    bookmark = current_user.bookmarks.create(bookmark_params)
    render json: bookmark, status: 201
  end

  def update
    @bookmark.update(bookmark_params)
    render json: 'Bookmark Updated', status: 200
  end

  def destroy
    @bookmark.destroy
    render json: 'Bookmark Deleted', status: 204
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :user_id, :category_id, :language_id)
  end
end

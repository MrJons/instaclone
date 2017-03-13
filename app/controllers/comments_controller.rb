class CommentsController < ApplicationController
  before_action :set_photo, only: [:new, :create]

  def new
    @comment = @photo.comments.new
  end

  def create
    @comment = @photo.comments.new(comment_params)
    @comment.photo_id = @photo.id
    @comment.user = current_user 

    respond_to do |format|
      if @comment.save
        format.html { redirect_to photos_path, notice: 'Comment was successfully posted.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

end

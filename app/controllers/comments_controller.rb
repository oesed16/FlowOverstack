class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:notice] = "El comentario fue publicado con éxito."
      redirect_to @commentable
    else
      flash[:alert] = "La publicación del comentario falló, intenta nuevamente."
      redirect_to @commentable
    end
  end

  private
    
  def comment_params
      params.require(:comment).permit(:description)
  end
end

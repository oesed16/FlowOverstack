class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def new
    @comment = Comment.new
  end 

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

      if @comment.save
        flash[:notice] = "El comentario fue publicado con éxito."
        redirect_to request.referrer
      else
        flash[:alert] = "La publicación del comentario falló, intenta nuevamente."
        redirect_to request.referrer
      end
  end

  private
    
  def comment_params
    params.require(:comment).permit(:description)
  end

  def find_commentable
    @commentable = Question.find_by_id(params[:question_id]) if params[:question_id].present?
    @commentable = Answer.find_by_id(params[:answer_id]) if params[:answer_id].present?
  end
end

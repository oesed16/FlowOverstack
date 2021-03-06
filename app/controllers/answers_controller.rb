class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @answer = Answer.new
  end
  
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:notice] = "La respuesta fue creada exitosamente"
      redirect_to question_path(@question.id)
    else
      flash[:alert] = "El registro de la respuesta falló, intenta nuevamente"
      redirect_to question_path(@question.id)
    end

  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end
end

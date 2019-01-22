class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @questions = Question.includes(:answers, :votes).order(created_at: :desc)
    if params[:s].present?
      @questions = @questions.where("title LIKE (?) OR description LIKE (?)", "%#{params[:s]}%", "%#{params[:s]}%")
    end
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    flash[:notice] = "La pregunta fue eliminada exitosamente"
    redirect_to root_path
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    if params[:question_id].present?
      @comments = @question.comments
    elsif params[:answer_id].present?
      @comments = @answers.comments
    end
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      flash[:notice] = "La pregunta fue creada exitosamente"
      redirect_to root_path
    else
      flash[:alert] = "El registro de la pregunta falló, intenta nuevamente"
      render :new 
    end

  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      flash[:notice] = "La pregunta fue modificada exitosamente"
      redirect_to root_path
    else
      flash[:alert] = "La actualización de la pregunta falló, intenta nuevamente"
      render :edit
    end
  end

  private

  def question_params
    params.require(:question).permit(:user_id, :title, :description, :s)
  end
end

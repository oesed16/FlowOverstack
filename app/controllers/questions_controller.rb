class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def destroy
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @answer = Answer.find(params[:id])
    if @commentable = @question
        @comments = @question.comments
    elsif @commentable = @answer
        @comments = @answer.comments
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
  end

  private

  def question_params
    params.require(:question).permit(:user_id, :title, :description)
  end
end

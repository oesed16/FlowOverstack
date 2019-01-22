class VotesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    
    def create
        if params[:question_id].present?
            question = Question.find(params[:question_id])
            question.votes.create(user: current_user)
        
            redirect_to request.referrer

        elsif params[:answer_id].present?
            answer = Answer.find(params[:answer_id])
            answer.votes.create(user: current_user)

            redirect_to request.referrer
        end
      end
      
      def destroy
        if params[:question_id].present?
            question = Question.find(params[:question_id])
            question.votes.where(user: current_user).take.try(:destroy)
        
            redirect_to request.referrer

        elsif params[:answer_id].present?
            answer = Answer.find(params[:answer_id])
            answer.votes.where(user: current_user).take.try(:destroy)

            redirect_to request.referrer
        end
      end
end

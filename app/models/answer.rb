class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable
  validates :user_id, :question_id, :description, presence: true
end

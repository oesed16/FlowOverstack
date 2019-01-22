class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  validates :user_id, :question_id, :description, presence: true

  def voted_answer_by?(user)
    votes.exists?(user: user)
  end
end

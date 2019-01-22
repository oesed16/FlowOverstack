class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  validates :user_id, :title, :description, presence: true

  def voted_question_by?(user)
    votes.exists?(user: user)
  end
  
end

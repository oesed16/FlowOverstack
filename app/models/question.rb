class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable
  validates :user_id, :title, :description, presence: true
end

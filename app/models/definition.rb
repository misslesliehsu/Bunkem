class Definition < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :votes
  has_many :voters, through: :votes
end

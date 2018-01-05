class Definition < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :votes
  has_many :voters, through: :votes

  validates_presence_of :content

  def vote_pct
    (self.votes.count.to_f / (self.game.player_count - 1)) * 100
  end
end

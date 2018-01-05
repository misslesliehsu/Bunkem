class User < ApplicationRecord
  has_secure_password
  has_many :definitions
  has_many :participants
  has_many :votes, foreign_key: "voter_id"
  has_many :games, through: :participants
  has_many :my_games, class_name: "Game", foreign_key: "owner_id"

  validates_presence_of :name
  validates_uniqueness_of :name

  #Who they’ve voted for
  def most_voted
    voted_for = {}
    self.votes.each do |vote|
      selection = vote.definition.user.name
      if selection == "THE BUNKER"
        selection = "the correct answer"
      end
      if voted_for[selection]
        voted_for[selection] += 1
      else
        voted_for[selection] = 1
      end
    end
    voted_for
  end

  #Games played
  def finished_games
    self.games.select do |game|
      game.done
    end
  end

  def games_played
    finished_games.count
  end

  #How many times they’ve won
  def games_won
    finished_games.select do |game|
      (game.final_points_hash.keys.first == self.name) && (game.final_points_hash.values[0] != game.final_points_hash.values[1])
    end.count
  end

  #Games lost
  def games_lost
    games_played - games_won
  end

  #Ranking of all players
  def self.top_players
    top_ten = User.all.sort_by {|user| user.lifetime_pts}.reverse
    top_ten.first(10).map do |user|
      {user.name => user.lifetime_pts}
    end
  end

  #Best Definition
  def best_definition
    self.definitions.max_by do |definition|
      definition.votes.count
    end
  end

  #Lifetime Bunks
  def lifetime_bunks
    self.definitions.inject(0) {|sum, d| sum + d.votes.count }
  end

end

class Game < ApplicationRecord
  has_many :participants
  has_many :definitions
  has_many :users, through: :participants

  def find_or_set_word
    self.update(word: Word.all.sample.word) if !self.word
    self.word
  end

  def status
    if !full?
      "Waiting for Players"
    elsif full? && !all_defs?
      "Waiting for Submissions"
    elsif full? && all_defs? && !all_voted?
      "Waiting for Votes"
    elsif all_voted?
      "Done"
    else
      "Something went horribly wrong!!!"
    end
  end

  def full?
    self.users.count == self.player_count
  end

  def all_defs?
    self.definitions.count >= self.player_count
  end

  def all_voted?
    vote_count == self.player_count
  end

  def definition_users
    self.definitions.map do |definition|
      definition.user
    end
  end

  def vote_count
    count = 0
    self.definitions.each do |definition|
      count += definition.votes.count
    end
    count
  end

  def definition_voters
    self.definitions.map do |definition|
      definition.voters
    end.flatten.compact
  end

  def set_real_definition
    self.definitions << Definition.create(user: User.find_by(name: "THE BUNKER"), game: self, content: Word.find_by(word: self.word).definition)
  end

  def assign_points
    #points for users who made votes associated to the right definition
    #points for users who made definitions earning votes
    #return hash of users & points
  end


end

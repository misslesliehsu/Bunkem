class Game < ApplicationRecord
  has_many :participants
  has_many :definitions
  has_many :users, through: :participants

  serialize :points_hash


  def find_or_set_word  #will return the game play word
    if !self.word
      set_word
    end
    self.word
  end


  def set_word
    play_word = Word.all.sample.word
    if used_words.include?(play_word)
      set_word
    else
      self.update(word: play_word)
    end
  end


  def used_words
    used_words =
    self.users.map do |user|
      user.games.map do |game|
        game.word
      end
    end.flatten.compact
  end


  def title
    if self.participants.empty?
      "Empty - #{self.id}"
    else
      "#{self.participants.first.user.name} - #{self.id}"
    end
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
    self.definitions << Definition.create(user: User.find_by(name: "THE BUNKER"), game: self, content: Word.find_by(word: self.word).definition.gsub(";",", or"))
  end

  def assign_points
    user_points = {}

    real_def = self.definitions.find_by(user: User.find_by(name: "THE BUNKER"))
    #points for users who made votes associated to the right definition
    self.definitions.each do |definition|
      user_points[definition.user.name] = definition.votes.count * 100 if definition != real_def
    end

    real_def.votes.each do |vote|
      user_points[vote.voter.name] += 100
    end
    #points for users who made definitions earning votes
    #return hash of users & points
    self.points_hash = user_points.sort_by {|key, value| value}.reverse.to_h
    self.save
    self.points_hash
  end

  def set_battle_id(b_id = self.id)
    self.battle_id = b_id
    self.save
  end

  def set_users(participant_ids)
    participant_ids.each do |p_id|
      self.users << Participant.find(p_id).user
    end
  end



end

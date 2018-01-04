class User < ApplicationRecord
  has_secure_password
  has_many :definitions
  has_many :participants
  has_many :votes, foreign_key: "voter_id"
  has_many :games, through: :participants
  has_many :my_games, class_name: "Game", foreign_key: "owner_id"

  validates_presence_of :name
  validates_uniqueness_of :name

  #Lifetime Points

  #Who they’ve voted for

  #How many times they’ve won

  #How many times they’ve guessed correctly

  #Who has voted for them

  #Games played

  #Games lost

  #Percent wins

  #Ranking of all players

  #Part of speech column?

  #Best Definition

  #Perfect Games

end

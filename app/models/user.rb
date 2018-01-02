class User < ApplicationRecord
  has_secure_password
  has_many :definitions
  has_many :participants
  has_many :votes, foreign_key: "voter_id"
  has_many :games, through: :participants
end

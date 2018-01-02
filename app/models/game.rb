class Game < ApplicationRecord
  has_many :participants
  has_many :definitions
  has_many :users, through: :participants
end

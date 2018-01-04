require 'rails_helper'

  describe "#find_or_set_word" do

    before do
      Word.create(word: "dog", definition: "fluffy animal")
      Word.create(word: "cat", definition: "fluffier animal")
      @words = Word.all.map do |entry|
        entry.word
      end

      @pastgame = Game.create(player_count:2)
      @pastgame.update(word:"cat")
      @player1 = User.create(name: "player1", password: "pw")
      @pastgame.users << @player1

      @game = Game.create(player_count: 4)
      @game.users <<@player1

    end

    it "ensures word returned has not been seen by any player in any previous game" do
      expect(@game.find_or_set_word).to eq("dog")
    end

  end

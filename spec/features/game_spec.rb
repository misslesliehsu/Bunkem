require 'rails_helper'


#GAME SETUP

  describe "game creation" do

    it "ensures newly created games must have an owner (User) and player_count" do
      expect(Game.create.valid?).to be(false)
    end

  end

  describe "#find_or_set_word" do

    before(:each) do  #will happen before each "it...." block
      @test = "test"
      Word.create(word: "dog", definition: "fluffy animal")
      Word.create(word: "cat", definition: "fluffier animal")
      @words = Word.all.map do |entry|
        entry.word
      end

      #player1 has seen "cat"
      @player1 = User.create(name: "player1", password: "pw")
      @pastgame1 = Game.create(player_count:2, owner: @player1)
      @pastgame1.update(word:"cat")
      Participant.create(game: @pastgame1, user:@player1)

      #player2 has seen "dog"
      @player2 = User.create(name: "player2", password: "pw")
      @pastgame2 = Game.create(player_count:2, owner: @player2)
      @pastgame2.update(word:"cat")
      Participant.create(game: @pastgame2, user:@player2)

    end


    it "ensures if there are no available (unused words), error is thrown" do
      #new game, but only "cat" & "dog" are available... should =>error
      @game = Game.create(player_count: 4)
      @game.users << [@player1, @player2]
      expect {@game.find_or_set_word}.to raise_error(StandardError)
    end


    it "ensures only unused word is set as play_word" do
      @game = Game.create(player_count:2, owner: @player1)
      Participant.create(game: @game, user:@player1)
      expect(@game.find_or_set_word).to eq("dog")
    end


  end


#GAME PLAY

  describe "game play methods" do

    before(:each) do
      # set up a game with owner & player count
      @player1 = User.create(name: "player1", password: "pw")
      @player2 = User.create(name: "player2", password: "pw")
      @game = Game.create(player_count: 2, owner: @player1)

    end

    it "sets game status correctly" do
      expect(@game.status).to eq("Waiting for Players")
      Participant.create(game: @game, user: @player2)
      Participant.create(game: @game, user: @player1)
      expect(@game.status).to eq("Waiting for Submissions")
      @definition1 = Definition.create(game:@game, content: "testing", user:@player1)
      @definition2 = Definition.create(game:@game, content: "testing", user:@player2)
      expect(@game.status).to eq("Waiting for Votes")
      Vote.create(voter: @player1, definition: @definition2)
      Vote.create(voter: @player2, definition: @definition1)
      expect(@game.status).to eq("Votes In")
      @game.done = true
      expect(@game.status).to eq("Done")
    end

    it "assign_points correctly" do
      @bunker = User.create(name:"THE BUNKER", password: "pw")
      Participant.create(game: @game, user: @player2)
      Participant.create(game: @game, user: @player1)
      @definition1 = Definition.create(game:@game, content: "testing", user:@player1)
      @definition2 = Definition.create(game:@game, content: "testing", user:@player2)
      @definition3 = Definition.create(game:@game, content: "testing", user:@bunker)
      Vote.create(voter: @player1, definition: @definition2)
      Vote.create(voter: @player2, definition: @definition2)
      expect(@game.assign_points).to eq({@player2.name => 200, @player1.name => 0})
      @game.update(battle_id: 100)
      @game.calc_results
      expect(@player1.lifetime_pts).to eq(0)
      expect(@player2.lifetime_pts).to eq(200)
      end

end


# SESSION / ACCESS

  describe "recognizing users" do

    it "recognizes the logged in user" do
    end

    it "recognizes when a user is viewing their own profile page" do
    end

    it "does not allow a player to submit definitions twice or vote twice" do
    end

  end

# STATS

  describe "calculates player stats" do

    it "accurately calculates lifetime points" do
    end

    it "accommodates a tie for Top Player" do
    end

  end

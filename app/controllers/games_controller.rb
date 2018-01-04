class GamesController < ApplicationController

  skip_before_action :authorized, only: [:index]

  def index
    @games = Game.all
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      if !@game.users.include?(current_user)
        @participant = Participant.create(user: current_user, game:@game)
      end
      @game.set_battle_id
      redirect_to @game
    else
      flash[:errors] = @game.errors.full_messages
      redirect_to root_path
    end
  end

  def next_round
    @game = Game.new(player_count:params[:player_count]) 
    if @game.save
      @game.set_users(params[:participants])
      @game.set_battle_id(params[:battle_id])
      redirect_to @game
    else
      flash[:errors] = @game.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @game = Game.find(params[:id])
    @definition = Definition.new
    @vote = Vote.new
  end



  private

  def game_params
    params.require(:game).permit(:player_count)
  end

end

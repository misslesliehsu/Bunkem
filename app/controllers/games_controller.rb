class GamesController < ApplicationController

  skip_before_action :authorized, only: [:index]

  def index
    @games = Game.all
  end

  def create
    @game = @game.new(game_params)
    if @game.save
      redirect_to @game
    else
      redirect_to root_path
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:player_count)
  end

end

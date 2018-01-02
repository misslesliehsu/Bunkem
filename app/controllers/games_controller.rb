class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def create
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params(:)
  end

end

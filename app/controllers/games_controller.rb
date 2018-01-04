class GamesController < ApplicationController

  skip_before_action :authorized, only: [:index]

  def index
    @games = Game.all
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.owner = current_user
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
    @game.owner = current_user
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
    @next = Game.all.where("battle_id = ?", @game.battle_id).where("id > ?", @game.id).first
  end

  def results
    @battle_id = params[:battle_id].to_i

    @all_games = Game.all.select do |game|
      game.battle_id == @battle_id
    end

    @final_points_hash = {}
    @all_games.each do |game|
      @final_points_hash = @final_points_hash.merge(game.points_hash){|player, allpts, points| allpts + points}
    end

    if !@all_games.last.done
      @final_points_hash.each do |username, pts|
        @user = User.find_by(name:username)
        @user.update(lifetime_pts: @user.lifetime_pts += pts)
      end
      @all_games.last.update(done: true)
    end

    @final_points_hash = @final_points_hash.sort_by {|key, value| value}.reverse.to_h
  end


  private

  def game_params
    params.require(:game).permit(:player_count)
  end

end

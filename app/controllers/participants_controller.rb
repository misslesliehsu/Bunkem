class ParticipantsController < ApplicationController

  def create
    @game = Game.find(params[:game])
    if !@game.users.include?(current_user)
      @participant = Participant.create(user: current_user, game:@game)
    end
    redirect_to @game
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to games_path
  end

end

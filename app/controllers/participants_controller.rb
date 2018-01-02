class ParticipantsController < ApplicationController

  def create
    @game = Game.find(params[:game])
    @participant = Participant.create(user: current_user, game:@game)
    redirect_to @game
  end

  def destroy
  end

end

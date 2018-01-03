class VotesController < ApplicationController

  def create
    @vote = Vote.new(vote_params)
    @vote.voter_id = current_user_id
    if @vote.save
      redirect_to @vote.definition.game
    else
      "this is weird!"
    end

  end


  private

  def vote_params
    params.require(:vote).permit(:voter_id, :definition_id)
  end

end

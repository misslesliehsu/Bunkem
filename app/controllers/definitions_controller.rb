class DefinitionsController < ApplicationController

  def create
    definition_params[:content] = definition_params[:content].downcase
    @definition = Definition.new(definition_params)
    @game = Game.find(params[:definition][:game_id])
    if @definition.save
      redirect_to @game
    else
      flash[:error] = "Please Enter a Definition"
      redirect_to @game
    end
  end

  private

  def definition_params
    params.require(:definition).permit(:game_id, :user_id, :content)
  end

end

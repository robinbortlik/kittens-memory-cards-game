class GamesController < ApplicationController

  def new
    game = Builders::Game.build

    redirect_to game_path(game.id)
  end

  def show
    @game = Repositories::Game.find(params[:id])
    @game.register_user(session[:user_id])

    Turbo::StreamsChannel.broadcast_replace_to("game_#{@game.id}", partial: 'games/game', locals: { game: @game }, target: "game_#{@game.id}")
  end

  def reset
    @game = Repositories::Game.find(params[:id])
    @game.reset!

    redirect_to game_path(@game.id)
  end
end

class CardsController < ApplicationController

  def show

    @game = Repositories::Game.find(params[:game_id])
    return render(inline: '') unless @game.is_playing?(session[:user_id])

    @card = @game.flip_card(params[:id])

    Turbo::StreamsChannel.broadcast_replace_to("game_#{@game.id}", partial: 'cards/card', locals: { card: @card, game: @game }, target: "card_#{@card.id}")

    if @game.resolve_cards?
      @game.resolve_cards!
      Turbo::StreamsChannel.broadcast_replace_to("game_#{@game.id}", partial: 'games/game', locals: { game: @game }, target: "game_#{@game.id}")
    end

    render inline: ''
  end
end

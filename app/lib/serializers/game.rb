class Serializers::Game
  def self.call(game)
    {
      id: game.id,
      cards: game.cards.map{ |card| Serializers::Card.call(card) },
      users: game.users,
      current_player: game.current_player
    }
  end
end

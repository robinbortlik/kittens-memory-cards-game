class Deserializers::Game
  def self.call(data)
    Game.new(
      id: data.fetch("id"),
      cards: data.fetch("cards").map { |card| Card.new(card) },
      users: data.fetch("users"),
      current_player: data.fetch("current_player")
    )
  end
end

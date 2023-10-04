class Builders::Game

  def self.build
    game = Game.new(id: SecureRandom.uuid, cards: Builders::GameCards.build )
    game.save
  end
end

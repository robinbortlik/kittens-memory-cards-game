class Repositories::Game
  def self.find(id)
    new.find(id)
  end

  def self.save(game)
    new.save(game)
  end

  def find(id)
    data = Redis.current.hgetall("game:#{id}")
    Deserializers::Game.call(JSON.parse(data.fetch("data")))
  end

  def save(game)
    Redis.current.hset("game:#{game.id}", "data", Serializers::Game.call(game).to_json)
    game
  end
end

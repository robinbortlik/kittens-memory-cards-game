class Builders::GameCards
  def self.build(pairs=8)
    cards = []
    pairs.times.map do |i|
      cards << Card.new(id: SecureRandom.uuid, value: i, flipped: false, resolved: false)
      cards << Card.new(id: SecureRandom.uuid, value: i, flipped: false, resolved: false)
    end
    cards.shuffle!
  end
end

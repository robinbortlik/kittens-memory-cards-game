class Serializers::Card
  def self.call(card)
    {
      id: card.id,
      value: card.value,
      flipped: card.flipped?,
      resolved: card.resolved?,
      user: card.user
    }
  end
end

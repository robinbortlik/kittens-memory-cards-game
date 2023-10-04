class Card
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_reader :id, :value, :flipped
  attr_accessor :user

  def initialize(data)
    @data = data.symbolize_keys
    @id = @data[:id]
    @value = @data[:value]
    @flipped = @data[:flipped]
    @resolved = @data[:resolved]
    @user = @data[:user]
  end

  def  flip!
    @flipped = !flipped?
  end

  def flipped?
    @flipped
  end

  def resolve(player)
    @flipped = false
    @resolved = true
    @user = player
  end

  def resolved?
    @resolved
  end
end

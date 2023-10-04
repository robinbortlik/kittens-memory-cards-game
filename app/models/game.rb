class Game
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :id, :cards, :users, :current_player

  def initialize(data)
    @data = data.symbolize_keys
    @id = @data[:id]
    @cards = @data[:cards]
    @users = @data[:users].to_a
    @current_player = data[:current_player]
  end

  def flip_card(card_id)
    card = cards.find { |card| card.id == card_id }
    card.flip!
    save
    card
  end

  def resolve_cards?
    cards.select(&:flipped?).size == 2
  end

  def resolve_cards!
    flipped_cards = cards.select(&:flipped?)
    if flipped_cards.map(&:value).uniq.size == 1
      flipped_cards.each{ |card| card.resolve(current_player)}
    else
      flipped_cards.each(&:flip!)
      swap_player
    end

    save
  end

  def finished?
    !cards.find{|c| !c.resolved? }
  end

  def winner
    return nil unless finished?
    @winner ||= users.max_by{ |user_id| cards_count_for_user(user_id) }
  end

  def is_playing?(user_id)
    current_player == user_id
  end

  def current_player
    @current_player ||= users.first
  end

  def cards_count_for_user(user_id)
    cards.select{ |card| card.user == user_id }.size / 2
  end

  def swap_player
    index = @users.index(current_player)
    @current_player = users[index + 1] || users.first
  end

  def register_user(user_id)
    @users ||= []
    @users << user_id unless @users.include?(user_id)
    save
  end

  def save
    Repositories::Game.save(self)
  end

  def reset!
    @cards = Builders::GameCards.build
    @current_player = users.first
    save
  end

end

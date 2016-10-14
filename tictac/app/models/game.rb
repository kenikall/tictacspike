class Game < ApplicationRecord
  def self.start(player1, player2)
    cross, naught = [player1, player2].shuffle

    ActionCable.server.broadcast "player_#{cross}", {action: "game_start", msg: "Cross"}
    ActionCable.server.broadcast "player_#{naught}", {action: "game_start", msg: "Naught"}

    REDIS.set("opponent_for:#{cross}", naught)
    REDIS.set("opponent_for:#{nought}", cross)
  end
end

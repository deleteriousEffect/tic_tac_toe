class Board

  attr_accessor :current_bord
  
  def initialize
    @current_bord = [%w(_ _ _), %w(_ _ _), %w(_ _ _)]
  end

  def print_board
    @current_bord.each do |a| 
      print a.join(' '), "\n" 
    end
  end

  def victory?
  end

  def start_round
  end
  
  def start_turn
  end

  class Player
    def place_mark
    end

    def valid_move?
    end

    def score
    end

  end
end

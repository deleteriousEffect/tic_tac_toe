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
    puts 'Welcome to Tic Tac Toe!'

    puts 'Who is our first player?'
    player1 = Player.new(gets.chomp)

    puts 'Who is our second player?'
    player2 = Player.new(gets.chomp)

    puts "#{player1.name}, #{player2.name}. Are you ready!?"

    start_turn
  end

  def start_turn
  end

  class Player
    attr_accessor :name, :score

    def initialize(name)
      @name = name
      @score = 0
    end

    def place_mark
    end

    def valid_move?
    end

    def score
    end
  end
end

board = Board.new

board.start_round

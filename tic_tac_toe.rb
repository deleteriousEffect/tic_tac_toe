class Board
  attr_accessor :current_bord, :number_of_turns

  def initialize
    @current_bord = [%w(_ _ _), %w(_ _ _), %w(_ _ _)]
    @number_of_turns = 0
  end

  def print_board
    @current_bord.each do |a|
      print a.join(' '), "\n"
    end
  end

  def victory?
    false
  end

  def start_round
    puts 'Welcome to Tic Tac Toe!'

    puts 'Who is our first player?'
    @player1 = Player.new(gets.chomp)

    puts 'Who is our second player?'
    @player2 = Player.new(gets.chomp)

    puts "#{@player1.name}, #{@player2.name}. Are you ready!?"

    start_turn
  end

  def start_turn
    loop do
      print_board
      break if victory?
      if @number_of_turns.even?
        @player1.place_mark
      else
        @player2.place_mark
      end
      @number_of_turns += 1
    end
  end

  class Player
    attr_accessor :name, :score

    def initialize(name)
      @name = name
      @score = 0
    end

    def place_mark
      puts "I'm a dummy method!"
    end

    def valid_move?
    end

    def score
    end
  end
end

board = Board.new

board.start_round

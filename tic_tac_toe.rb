class Board
  attr_accessor :current_board, :number_of_turns

  def initialize
    @current_board = [%w(_ _ _), %w(_ _ _), %w(_ _ _)]
    @number_of_turns = 0
  end

  def print_board
    @current_board.each do |a|
      print a.join(' '), "\n"
    end
  end

  def victory?
    false
  end

  def tie?
    if @current_board.flatten.none? { |e| e == '_' }
      puts "It's a tie! Everyone is a loser!"
      true
    end
  end

  def start_round
    puts 'Welcome to Tic Tac Toe!'

    puts 'Who is our first player?'
    @player1 = Player.new(gets.chomp, '#', self)

    puts 'Who is our second player?'
    @player2 = Player.new(gets.chomp, 'O', self)

    puts "#{@player1.name}, #{@player2.name}. Are you ready!?"

    start_turn
  end

  def set_board(collumn, row, mark)
    @current_board[collumn][row] = mark
  end

  def start_turn
    loop do
      print_board
      break if victory? || tie?
      if @number_of_turns.even?
        @player1.place_mark(@player1.ask_for_row, @player1.ask_for_collumn)
      else
        @player2.place_mark(@player2.ask_for_row, @player2.ask_for_collumn)
      end
      @number_of_turns += 1
    end
  end

  class Player
    attr_accessor :name, :score, :mark, :board

    def initialize(name, mark, board)
      @name = name
      @score = 0
      @mark = mark
      @board = board
    end

    def ask_for_row
      puts "#{@name}, what row do you wish to place your mark on? \n1, 2, or 3?"
      row = gets.chomp.to_i - 1
    end

    def ask_for_collumn
      puts "What collumn do you wish to place your mark on? \n1, 2, or 3?"
      collumn = gets.chomp.to_i - 1
    end

    def place_mark(row, collumn)
      if valid_move?(row, collumn)
        @board.set_board(row, collumn, @mark)
      else
        place_mark(ask_for_row, ask_for_collumn)
      end
    end

    def valid_move?(row, collumn)
      if @board.current_board[row][collumn] == '_'
        true
      else
        puts "You can't mark over another mark! Try a black space..."
      end
    end

    def score
    end
  end
end

board = Board.new

board.start_round

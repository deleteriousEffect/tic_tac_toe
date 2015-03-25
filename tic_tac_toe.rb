# This is simple command line tic tac toe game for two players.
# Players enter their names and keep track of their scores.
# After each game, players scores are displayed and players may choose to 
# continue playing or exit the program.
# 
#
# Manages turns and checks for victory.
class Board
  attr_accessor :current_board, :number_of_turns

  def initialize
    @current_board = [%w(_ _ _), %w(_ _ _), %w(_ _ _)]
    @number_of_turns = 0
  end

  # Displays the current board.
  def print_board
    @current_board.each do |a|
      print a.join(' '), "\n"
    end
  end

  # Checks if there are three matching marks on a row.
  def row_checker(mark)
    @current_board.each do |row|
      return true if row.all? { |element| element == mark }
    end
    false
  end

  # Checks if there are three matching marks on a collumn.
  def collumn_checker(mark)
    i = 0

    while i < @current_board.length
      matches = []
      @current_board.each do |row|
        matches << row[i]
      end
      return true if matches.all? { |element| element == mark }
      i += 1
    end
    false
  end

  # Checks if there are three matching marks on a diagonal.
  def diagonal_checker(mark)
    element =  0
    diag = []
    anti_diag = []

    @current_board.each do |row|
      diag << row[element]
      element += 1
      anti_diag << row[-element]
    end
    return true if diag.all? { |e| e == mark } || anti_diag.all? { |e| e == mark }
    false
  end

  # Checks to see if a victory condition has been met and increase victor's score
  # and displays win message.
  def victory?(player)
    if row_checker(player.mark) ||
       diagonal_checker(player.mark) ||
       collumn_checker(player.mark)

      player.score_increase

      puts "#{player.name}(#{player.get_score} wins) is the winner!"
      true
    else
      false
    end
  end

  # Determines if there is a tie.
  def tie?
    if @current_board.flatten.none? { |e| e == '_' }
      puts "It's a tie! Everyone is a loser!"
      true
    end
  end

  # Begins a game and instantiates players.
  def start_round
    puts 'Welcome to Tic Tac Toe!'

    puts 'Who is our first player?'
    @player1 = Player.new(gets.chomp, '#', self)

    puts 'Who is our second player?'
    @player2 = Player.new(gets.chomp, 'O', self)

    puts "#{@player1.name}, #{@player2.name}. Are you ready!?"

    start_turn
  end

  # Changes a mark on the board to a new mark.
  def set_board(collumn, row, mark)
    @current_board[collumn][row] = mark
  end

  # Reset board to starting condition.
  def clear_board
    @current_board = [%w(_ _ _), %w(_ _ _), %w(_ _ _)]
  end

  # Starts a new turn if players wish to continue.
  def continue?
    puts "Do you wish do continue?\n1:Yes, 2: No"
    answer = gets.chomp

    if answer == '1'
      clear_board
      start_turn
    else
      puts 'Thanks for playing!'
      exit
    end
  end

  # Displays board and manages player turns.
  def start_turn
    loop do
      print_board
      if @number_of_turns.even?
        @player1.place_mark(@player1.ask_for_row, @player1.ask_for_collumn)
        break if victory?(@player1) || tie?
      else
        @player2.place_mark(@player2.ask_for_row, @player2.ask_for_collumn)
        break if victory?(@player2) || tie?
      end
      @number_of_turns += 1
    end
    continue?
  end

  # Keeps track of user names and scores,
  # allows users to place marks on the board.
  class Player
    attr_accessor :name, :score, :mark, :board

    def initialize(name, mark, board)
      @name = name
      @score = 0
      @mark = mark
      @board = board
    end

    # Allows user to pick a row to place thier mark on.
    def ask_for_row
      puts "#{@name}, what row do you wish to place your mark on? \n1, 2, or 3?"
      row = gets.chomp.to_i - 1
    end

    # Allows user to pick a collumn to place thier mark on.
    def ask_for_collumn
      puts "What collumn do you wish to place your mark on? \n1, 2, or 3?"
      collumn = gets.chomp.to_i - 1
    end

    # Changes selected space on board to the player's mark.
    def place_mark(row, collumn)
      if valid_move?(row, collumn)
        @board.set_board(row, collumn, @mark)
      else
        place_mark(ask_for_row, ask_for_collumn)
      end
    end

    # Checks if user has selected a previously marked spot on the board.
    def valid_move?(row, collumn)
      if @board.current_board[row][collumn] == '_'
        true
      else
        puts "You can't mark over another mark! Try a black space..."
      end
    end

    # Increases player's score by one point.
    def score_increase
      @score += 1
    end

    def get_score
      @score
    end
  end
end

board = Board.new

board.start_round

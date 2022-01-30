class Player
  attr_reader :marker

  def initialize(marker, name=nil)
    @marker = marker || 'X'
    @name = name || "Player"
  end

  def full_name
    "#{@name} (#{@marker})"
  end
end


class Game
  MAXIMUM_MOVES_PER_GAME = 9

  def initialize
    @player1 = Player.new('X')
    @player2 = Player.new('O')

    pp "#{@player1.full_name} if player 1"
    pp "#{@player2.full_name} if player 2"
    @current_player = @player1
    @turn_number = 1
    row = [' ', ' ', ' ']
    @board = [
      row.dup,
      row.dup,
      row.dup,
    ]
  end

  def get_move
    puts "#{@current_player.full_name}, it's your turn!"
    legal_move_made = false
    until legal_move_made
      player_input = gets.chomp.split(/\s+/).map(&:to_i)
      legal_move_made = legal_move?(*player_input)
      unless legal_move_made
        puts "Sorry, #{@current_player.full_name}, this is not a legal move! Try again."
      end
    end

    move(*player_input)
  end

  def print_board
    puts "========TURN #{@turn_number }========="
    @board.each { |row| pp row }
    puts '======================='
  end

  def has_moves_left?
    @turn_number <= MAXIMUM_MOVES_PER_GAME
  end

  private

  def switch_current_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def move(row, col)
    @board[row][col] = @current_player.marker
    print_board
    @turn_number += 1
    switch_current_player
  end

  def space_unoccupied?(row, col)
    @board[row][col].strip.empty?
  rescue NoMethodError
    return false
  end

  def space_exists?(row, col)
    row <= 2 && col <= 2
  end

  def legal_move?(row, col)
    space_unoccupied?(row, col) && space_exists?(row, col)
  end
end


def play_game
  game = Game.new
  game.print_board
  while game.has_moves_left? do
    game.get_move
  end
  puts "No more moves left. Thanks for playing!"
end


play_game

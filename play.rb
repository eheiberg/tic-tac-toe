class Board
  @@board = nil
  @@turn = 0

  attr_reader :marker

  class << self
    def setup
      row = [' ', ' ', ' ']
      @@board = [
        row.dup,
        row.dup,
        row.dup,
      ]
    end

    def display
      setup unless @@board
      puts "========TURN #{@@turn }========="
      @@board.each { |r| pp r }
      puts '======================='
    end
  end

  def initialize(marker)
    @marker = marker
  end

  def place(row, col)
    if legal_move?(row, col)
      @@turn += 1
      @@board[row][col] = marker
      self.class.display
      return
    end

    puts 'This space is already occupied! Try again.'
  end

  private

  def legal_move?(row, col)
    @@board[row][col].strip.empty?
  end
end

# Begin play
Board.setup
p1 = Board.new('X')
p2 = Board.new('O')

p1.place(0, 0)
p2.place(0, 1)
p1.place(1, 1)
p2.place(2, 2)
p1.place(0, 1)
p1.place(0, 2)

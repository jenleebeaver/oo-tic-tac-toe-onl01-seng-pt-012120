
class TicTacToe

  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
end

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(user_input)
 user_input.to_i - 1
end

def move(index, current_player)
  @board[index] = current_player
end

def position_taken?(index) #this method is checking index values
  !(@board[index].nil? || @board[index] == " ") #.nil? returns true for nil and ! is NOT operator
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end

def turn_count
  turn = 0
  @board.each do |index|
    if index == "X" || index == "O"
      turn += 1
    end
  end
  return turn
end

def current_player
  num_turns = turn_count
  if num_turns % 2 == 0 #if the turn count is even then there is no remainder
    player = "X"
else
  player = "O"
end
  player
end

def turn
  puts "Please choose a number 1-9:" #asks user for move
  user_input = gets.chomp #recieves user/s input
  index = input_to_index(user_input) #translates input into an index value
  if valid_move?(index) #if the move is valid make the move
    player_token = current_player
    move(index, player_token)
    display_board #displays board
  else
    turn #asks for input again if turn is invalid
  end
end

def won?
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = @board[win_index_1]
    position_2 = @board[win_index_2]
    position_3 = @board[win_index_3]
    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      return win_combination
    else
      # do nothing
    end
  end
  return nil
end

def full?
  @board.all? {|index| index == "X" || index == "O"}
end

def draw?
  if !won? && full?
    return true
  else
    return false
  end
end

def over?
  if won? || draw?
    return true
  else
    return false
  end
end

def winner
  index = won?

  if index == nil
    return nil
  else
    if @board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play
  until over? == true
    turn
  end

  if won?
    puts "Congratulations #{winner()}!"
  elsif draw?
    puts "Cat's Game!"
  end
end

end

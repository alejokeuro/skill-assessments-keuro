
#con = stdin()

if (interactive()) {
  con <- stdin()
} else {
  con <- "stdin"
}

#create data frame with 0 rows and 3 columns
ttt_board <- data.frame(matrix(ncol = 3, nrow = 3))
#provide column names
colnames(ttt_board) <- c('1', '2', '3')
rownames(ttt_board) <- c('1', '2', '3')

available_positions = expand.grid(row = 1:3, col = 1:3)

cat("X or O? ")
user_symbol <- readLines(con = con, n = 1)
symbols = c("X", "O")

robot_symbol_idx = which(symbols != user_symbol)
robot_symbol = symbols[robot_symbol_idx]

print("Current board status:")
print(ttt_board)

receive_input = function(){
  # blablabla
  cat('Row?')
  row = readLines(con, n = 1)
  row = as.integer(row)
  cat('Col?')
  col = readLines(con, n = 1)
  col = as.integer(col)
  c(row, col)
}

execute_selection = function(selection, symbol){
  
  ttt_board[selection[1], selection[2]] = symbol
  
  positions_to_keep = 
    (available_positions$row != selection[1]) |
    (available_positions$col != selection[2])
  
  available_positions = available_positions[positions_to_keep,]
  list(available_positions, ttt_board)
  
}

is_symbol_winner = function(symbol){
  # Checks if the symbol ("X" or "O") has won the game
  user_positions = ttt_board == symbol
  row_sums = rowSums(user_positions, na.rm = TRUE)
  col_sums = colSums(user_positions, na.rm = TRUE)
  diag_sum = sum(diag(user_positions), na.rm = TRUE)
  antidiag_sum = sum(diag(user_positions[,3:1]), na.rm = TRUE)
  is_winner = any(c(row_sums, col_sums, diag_sum, antidiag_sum) == 3)
  is_winner
  
}

is_there_a_winner = FALSE


while(!is_there_a_winner){


  user_selection = receive_input()
  # user_selection = c(2, 2)
  play_outcomes = execute_selection(user_selection, user_symbol)
  available_positions = play_outcomes[[1]]
  ttt_board = play_outcomes[[2]]
  
  is_user_winner = is_symbol_winner(user_symbol)
  print("Current status of the game board:")
  print(ttt_board)
  
  if (is_user_winner){
    
    is_there_a_winner = TRUE
    
    cat("You won!")
    print("The available positions are:")
    print(available_positions)
    
    break
    
  }

  
  robot_selection = sample(1:length(available_positions), size = 1)
  robot_selection = unlist(available_positions[robot_selection, ])
  robot_selection
  
  available_positions
  play_outcomes = execute_selection(robot_selection, robot_symbol)
  
  print(paste("Robot has just played at row", 
              robot_selection[1], "and column", robot_selection[2], sep = ' '))
  available_positions = play_outcomes[[1]]
  ttt_board = play_outcomes[[2]]
  is_robot_winner = is_symbol_winner(robot_symbol)
  
  print("Current status of the game board:")
  print(ttt_board)
  
  if (is_robot_winner){
    
    is_there_a_winner = TRUE
    
    cat("The robot won!")
    print("The available positions are:")
    print(available_positions)
    
    break
    
  }
  

}
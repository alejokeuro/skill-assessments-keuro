
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

cat("Welcome to Tic-Tac-Toe!\n")
cat(paste("Please select a symbol (X or O) to use during your match. Keep in mind",
          "that X moves first.\n"))

user_symbol = "M"
bad_selection = FALSE
while (! user_symbol %in% c("X", "O")){

  if (bad_selection){
    
    cat("\nYour choice of symbol is not allowed.\n")
    cat("Please choose one of the following two symbols and hit Enter:\n")
    
  }
  cat("X or O? ")
  
  user_symbol <- readLines(con = con, n = 1)

  bad_selection = ! user_symbol %in% c("X", "O")
  
}
symbols = c("X", "O")

robot_symbol_idx = which(symbols != user_symbol)
robot_symbol = symbols[robot_symbol_idx]

#cat("Current board status:\n")
#print(ttt_board)

receive_user_selection = function(){
  
  position_not_available = TRUE
  
  while (position_not_available){
    
    not_valid_selection =  TRUE
    
    while (not_valid_selection){
      
      cat('Choose a row number: ')
      row = readLines(con, n = 1)
      cat('Choose a column number: ')
      col = readLines(con, n = 1)
      
      if (grepl("[1-3]{1,1}", row) &
          grepl("[1-3]{1,1}", col)){
        
        not_valid_selection = FALSE
        
      }else{
        
        cat("The row and/or column selected are not valid.\n")
        cat("Please choose a number among 1, 2 and 3 for your row and column selection.\n")
        
      }
      
      row = as.integer(row)
      col = as.integer(col)
      selection = c(row, col)
      
    }
    
    if (nrow(available_positions[available_positions$row == selection[1] &
                                 available_positions$col == selection[2],]) > 0){
      
      position_not_available = FALSE
      
    }else{
      
      cat("Your chosen position is not available on the board. Please try again.\n")
      cat("Current board status:\n")
      print(ttt_board)
      
    }
  
  }
  
  selection
  
}

receive_robot_selection = function() {
  
  robot_selection = sample(1:length(available_positions), size = 1)
  
  robot_selection = unlist(available_positions[robot_selection, ])
  
  robot_selection
}

execute_selection = function(selection, symbol){
  
  ttt_board[selection[1], selection[2]] = symbol
  
  positions_to_keep = 
    (available_positions$row != selection[1]) |
    (available_positions$col != selection[2])
  
  available_positions = available_positions[positions_to_keep,]
  list(available_positions, ttt_board)
  
}

let_symbol_play = function(symbol){
  
  if (symbol == user_symbol){
    
    selection = receive_user_selection()
    
  }else{
    
    selection = receive_robot_selection()
    
  }
  
  play_outcomes = execute_selection(selection, symbol)
  #play_outcomes = let_symbol_play("X")
  available_positions <<- play_outcomes[[1]]
  ttt_board <<- play_outcomes[[2]]
  
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

cat("INITIAL board status:\n")
print(ttt_board)

cat("INITIAL available positions:\n")
print(available_positions)

is_there_a_winner = FALSE

while(! is_there_a_winner & nrow(available_positions) > 0){
  
  let_symbol_play("X")
  cat("Available positions:\n")
  print(available_positions)

  if (is_symbol_winner("X")){
    
    is_there_a_winner = TRUE
    
    if("X" == user_symbol){
      print(ttt_board)
      cat("You won!\n")
      cat("Available positions after victory:\n")
      print(available_positions)
      break
      
    }else if ("X" == robot_symbol){
      print(ttt_board)
      cat("The robot won :( \nGood luck next time..!\n")
      cat("Available positions after victory:\n")
      print(available_positions)
      break
    }
  
  }else if (nrow(available_positions) == 0){
    
    cat("It's a draw!\n")
    cat("Current board status:\n")
    print(ttt_board)
    break
  }
  
  cat("Current board status:\n")
  print(ttt_board)
  
  # play_outcomes = 
  let_symbol_play("O")
  cat("Available positions:\n")
  print(available_positions)
  # available_positions = play_outcomes[[1]]
  # ttt_board = play_outcomes[[2]]

  if (is_symbol_winner("O")){
    
    is_there_a_winner = TRUE
    
    if("O" == user_symbol){
      print(ttt_board)
      cat("You won!\n")
      cat("Available positions after victory:\n")
      print(available_positions)
      break
      
    }else if ("O" == robot_symbol){
      print(ttt_board)
      cat("The robot won :( \nGood luck next time..!\n")
      cat("Available positions after victory:\n")
      print(available_positions)
      break
    }
    
  }else if (nrow(available_positions) == 0){
    
    cat("It's a draw!\n")
    cat("Current board status:\n")
    print(ttt_board)
    break
  }
  
  cat("Current board status:\n")
  print(ttt_board)
  
}

# 
# while(!is_there_a_winner){
# 
# 
#   user_selection = receive_input()
#   # user_selection = c(2, 2)
#   play_outcomes = execute_selection(user_selection, user_symbol)
#   available_positions = play_outcomes[[1]]
#   ttt_board = play_outcomes[[2]]
# 
#   is_user_winner = is_symbol_winner(user_symbol)
#   print("Current status of the game board:")
#   print(ttt_board)
# 
#   if (is_user_winner){
# 
#     is_there_a_winner = TRUE
# 
#     cat("You won!")
#     print("The available positions are:")
#     print(available_positions)
# 
#     break
# 
#   }
# 
# 
#   robot_selection = sample(1:length(available_positions), size = 1)
#   robot_selection = unlist(available_positions[robot_selection, ])
#   robot_selection
# 
#   available_positions
#   play_outcomes = execute_selection(robot_selection, robot_symbol)
# 
#   print(paste("Robot has just played at row",
#               robot_selection[1], "and column", robot_selection[2], sep = ' '))
#   available_positions = play_outcomes[[1]]
#   ttt_board = play_outcomes[[2]]
#   is_robot_winner = is_symbol_winner(robot_symbol)
# 
#   print("Current status of the game board:")
#   print(ttt_board)
# 
#   if (is_robot_winner){
# 
#     is_there_a_winner = TRUE
# 
#     cat("The robot won!")
#     print("The available positions are:")
#     print(available_positions)
# 
#     break
# 
#   }
# 
# 
# }
#!/usr/bin/env ruby

# millionaire
# A very simple game by Richard Marks <ccpsceo@gmail.com>
# (C) 2018, Richard Marks
# MIT License

def roll_die
  1 + Random.rand(6)
end

WINNING_TOTAL = 1_000_000
STARTING_TOTAL = 10
$user_money = STARTING_TOTAL
$user_bet = 1
$target_number = roll_die

def intro
  puts "Let's Play A Game"
  puts "..."
  puts "I'm going to give you $10 and your goal is to become a millionaire!"
  puts "You will place a bet from the money in your hand, and then you need"
  puts "to guess a number from 1 to 6 and I will roll a six sided die"
  puts "If you guessed the side of the die that faces up, then you will win."
  puts "If you guess incorrectly, you lost your bet, and if you run out of money, you lose."
  puts "LET'S PLAY!"
  puts ""
end

def get_bet
  puts "You have $#{$user_money}. How much would you like to bet?"
  number = gets.chomp
  number = number.to_i
  out_of_range = number < 1 or number > $user_money
  if out_of_range
    while out_of_range
      puts "You have $#{$user_money}. How much would you like to bet?"
      number = gets.chomp
      number = number.to_i
      out_of_range = number < 1 or number > $user_money
    end
  end
  number
end

def get_guess
  puts "Guess a number from 1 to 6"
  number = gets.chomp
  number = number.to_i
  out_of_range = number < 1 or number > 6
  if out_of_range
    while out_of_range
      puts "Guess a number from 1 to 6"
      number = gets.chomp
      number = number.to_i
      out_of_range = number < 1 or number > 6
    end
  end
  number
end

def get_play_again
  puts "Would you like to play again? (Y/N)"
  response = gets.chomp
  response.downcase.eql? 'y'
end

def win_round
  puts "Hey, that was lucky!"
  $user_money = $user_money + $user_bet
end

def lose_round
  puts "Aww, too bad!"
  $user_money = $user_money - $user_bet
end

def check_guess(number)
  if number == $target_number
    win_round
  else
    lose_round
  end
end

def check_gameover
  if $user_money <= 0
    puts "You're broke man! Sucks to be you!"
    puts "Hey, but at least it's just a game right?"
    return true
  elsif $user_money >= WINNING_TOTAL
    puts "CONGRATULATIONS! You're a millionaire!"
    puts "Too bad this is just a game! Oh well."
    return true
  end
  return false
end

def game_loop
  $user_money = STARTING_TOTAL
  $target_number = roll_die
  gameover = false
  until gameover
    if !gameover
      $user_bet = get_bet
      $target_number = roll_die
      check_guess get_guess
    end
    gameover = check_gameover
  end
end

def main_loop
  intro
  playing = true
  while playing
    game_loop
    playing = get_play_again
  end
  puts "Thanks for playing!"
end

if __FILE__ == $0
  main_loop
end

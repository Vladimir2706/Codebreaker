require_relative 'game'
require_relative 'constants'
# require 'pry'
require 'yaml'

module Codebreaker
  class Interface
    def initialize
      @username = 'New User'
    end

    def initialize_game
      @game = Game.new
      greeting
      start_menu
    end

    def start_menu
      show_start_menu
      case _guess = input
      when '1' then set_user_name
      when '2' then play_game
      when '3' then show_score
      when '4' then show_rools
      when '5' then goodbuy
      else puts 'Incorrect'
      end
    end

    def set_user_name
      puts "\nPlease, write your name"
      @username = input
      validate_user_name
      puts "\n Username \"#{@username}\" was succesfully set up!"
      start_menu
    end

    def play_game
      remainder_of_hints_and_attempts
      puts "\nPlease, write your code"
      until @game.loose?
        user_suggested_code = input
        @game.start(user_suggested_code)
        if @game.win?
          show_win_message
          end_game
        elsif @game.loose?
          show_loose_message
          end_game
        else
          ask_for_hint
        end
      end
    end

    def ask_for_hint
      puts QUESTION_FOR_HINT
      case _help = input.downcase
      when 'y'
        @game.use_hint
        play_game
      when 'n'
        play_game
      else
        puts "Please, give the correct answer"
        ask_for_hint
      end
    end

    def ask_for_new_game
      puts QUESTION_FOR_NEW_GAME
      case _help = input.downcase
      when 'y'
        initialize_game
      when 'n'
        goodbuy
      else
        puts "\nPlease, give the correct answer"
        ask_for_new_game
      end
    end

    def validate_user_name
      raise ArgumentError, 'Username is too short' if @username.length < 3 # /^{3,25}$/
      raise ArgumentError, 'Username is too long' if @username.length > 25 # /^{3,25}$/
    end

    def remainder_of_hints_and_attempts
      print "\nYou have #{@game.instance_variable_get(:@attempts)} attempts"
      print " and #{@game.instance_variable_get(:@hints)} hints.\n"
    end

    def goodbuy
      puts GOODBUY_MESSAGE
      exit
    end

    def input
      gets.chomp.strip
    end

    def greeting
      puts GREETING
    end

    def show_start_menu
      puts START_MENU
    end

    def show_loose_message
      puts LOOSE_MESSAGE
    end

    def end_game
      @game.count_score
      save_game_data_to_yaml
      ask_for_new_game
    end

    def show_win_message
      puts CONGRATULATIONS
    end

    def save_game_data_to_yaml(file_name = 'scores_table.yaml')
      collect_game_data
      File.new(file_name, 'a') unless File.exist?(file_name)
      File.open(file_name, 'a') do |file|
        file.write(@game_data.to_yaml)
      end
    end

    def collect_game_data
      @game_data = {
        Username: @username,
        Score: @game.instance_variable_get(:@score),
        Remaining_attempts: @game.instance_variable_get(:@attempts),
        Remaining_hints: @game.instance_variable_get(:@hints),
        Secret_cod_of_game: @game.instance_variable_get(:@secret_code),
        Date: "#{DateTime.now.strftime("%d/%m/%Y %H:/%M")}"
      }
    end

    def read_from_yaml(file_name = 'scores_table.yaml')
      if File.exist?(file_name)
        File.open(file_name, 'r') do |file|
          file.each_line do |line|
            puts line
          end
        end
      else
        puts 'There is no such file.'
      end
    end

    def show_score
      read_from_yaml
      start_menu
    end

    def show_rools
      puts ROOLS
      start_menu
    end
  end
end

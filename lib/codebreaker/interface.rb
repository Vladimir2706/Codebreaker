require_relative 'game'
require_relative 'constants'
require 'pry'

module Codebreaker
  class Interface
    def initialize
      @game = Game.new
      @username = 'New User'
    end

    def initialize_game
      greeting
      start_menu
    end

    def start_menu
      show_start_menu
      case guess = input
      when '1' then set_user_name
      when '2' then play_game
      when '3' then show_score
      when '4' then goodbuy
      else puts 'Incorrect'
      end
    end

    def set_user_name
      puts "Please, write your name"
      name = input
      validate_user_name(name)
      @username = name
      return start_menu
    end

    def play_game
      puts 'Please, write your code'
      until @game.loose?
        user_suggested_code = input
        @game.start(user_suggested_code)
        @game.show_secret_code
        @game.win? ? show_win_message : ask_for_hint
      end
      show_loose_message
      start_menu
    end

    def ask_for_hint
      puts QUESTION_FOR_HINT
      case help = input
      when 'y'
        @game.use_hint
        binding.pry
        play_game
      when 'n'
        play_game
      else
        puts "Please, give the correct answer"
        ask_for_hint
      end
    end

    def validate_user_name(name)
      raise ArgumentError, 'Username is too short' unless input =~ /^{3,25}$/
      raise ArgumentError, 'Username should be onle from Alphabets letters and numbers' if input =~ /^[\w\s]$/
    end

    def goodbuy
      puts 'Goodbuy'
    end

    def input
      gets.chomp.strip.downcase
    end

    def greeting
      puts GREETING
    end

    def show_start_menu
      puts START_MENU
    end

    def show_loose_message
      puts 'Try again! :('
    end

    def show_win_message
      puts '!!!CONGRATULATIONS!!!'
      start_menu
    end

    # def game_menu
    #   show_game_menu
    #   case decision = input
    #   when '1'
    #     set_user_name
    #   when '2'
    #     play_game
    #   when '3'
    #     start_menu
    #   end
    # end

    # def game_process
    #   game_menu
    #   play_game
    # end
    #
    # def start_menu
    #   show_start_menu
    #   case guess = input
    #   when '1' then game_process
    #   when '2' then show_score
    #   when '3' then goodbuy
    #   else puts 'Incorrect'
    #   end
    # end

    # def show_game_menu
    #   puts GAME_MENU
    # end
  end
end

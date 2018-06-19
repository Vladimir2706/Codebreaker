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
      # name = input
      @username = input
      validate_user_name
      return start_menu
    end

    def play_game
      puts 'Please, write your code'
      until @game.loose?
        user_suggested_code = input
        @game.start(user_suggested_code)
        # binding.pry
        @game.show_secret_code
        @game.win? ? show_win_message : ask_for_hint
      end
      show_loose_message
      initialize_game
    end

    def ask_for_hint
      puts QUESTION_FOR_HINT
      case help = input
      when 'y'
        @game.use_hint
        # binding.pry
        play_game
      when 'n'
        play_game
      else
        puts "Please, give the correct answer"
        ask_for_hint
      end
    end

    def validate_user_name
      raise ArgumentError, 'Username is too short' if @username.length < 3 # /^{3,25}$/
      raise ArgumentError, 'Username is too long' if @username.length > 25 # /^{3,25}$/
      # raise ArgumentError, 'Username should be onle from Alphabets letters and numbers' if @username.match /^[\w\s]$/
    end

    def goodbuy
      puts 'Goodbuy'
      exit
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
      save_game_data_to_yaml
      # write_to_yaml
      initialize_game
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
        Remaining_attempts: @game.instance_variable_get(:@attempts),
        Remaining_hints: @game.instance_variable_get(:@hints),
        Secret_cod_of_game: @game.instance_variable_get(:@secret_code),
        Date: "#{DateTime.now.strftime("%d/%m/%Y %H:/%M")}"
      }
    end

    # def write_to_yaml(file_name = 'scores_table.yaml')
    #   collect_game_data
    #   File.new(file_name, 'a') unless File.exist?(file_name)
    #   File.open(file_name, 'a') do |file|
    #     YAML.dump(@game_data, file)
    #   end
    # end

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
  end
end

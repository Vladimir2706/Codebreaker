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
      input
      validate_user_name
      @username = input
      start_menu
    end

    def play_game
      input
      @game.start
      @game.win? 
    end

    def ask_for_hint
      QUESTION_FOR_HINT
      case help = input
      when 'y'
        @game.use_hint
      when 'n'
        play_game
      else
        puts "Please, give the correct answer"
      end
    end

    def validate_user_name(input)
      raise ArgumentError, 'Username is too short' unless input.length < 3
      raise ArgumentError, 'Username is too long' unless input.length > 25
      raise ArgumentError, 'Username should be onle from Alphabets letters and numbers' if input =~ /^[\w\s]/
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

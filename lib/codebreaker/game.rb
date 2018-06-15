require_relative 'interface'
require_relative 'constants'

module Codebreaker
  ABSENT_HITNS_MESSAGE = 'Sorry, you have no hints'

  class Game
    attr_reader :attempts, :hints, :result_of_comparing

    def initialize
      @secret_code = generate_code
      @user_suggested_code = ''
      @result_of_comparing = ''
      @attempts = 2
      @hints = 10
    end

    def generate_code # absent in rspec, becouse generated code check in initialize
      (1..4).map { rand(1..6) }.join
    end

    def validate_input(input)
      raise ArgumentError, 'Type exactly 4 integer' unless input.length == 4
      raise ArgumentError, 'Type only integers from 1 to 6' if input =~ /[^1-6]/
    end

    def compare_codes(user_suggested_code)
      @result_of_comparing = ''
      @secret_code.each_char.with_index do |number, index|
        if number == @user_suggested_code[index]
          @result_of_comparing << '+'
        elsif @user_suggested_code.include?(number)
          @result_of_comparing << '-'
        end
      end
      puts @result_of_comparing.chars.sort.join
    end

    def start(user_suggested_code)
      @user_suggested_code = user_suggested_code
      if @attempts > 0
        decrease_attempts
        validate_input(user_suggested_code)
        compare_codes(user_suggested_code)
      end
    end

    def show_result_of_comparing

    end

    def win?
      @result_of_comparing == '++++'
    end

    def loose?
      @attempts.zero?
    end
    #
    # def loose
    #   if @attempts.zero?
    #     show_loose_message
    # end

    def show_win_message
      # Show win messahe
    end

    def decrease_attempts
      @attempts -= 1
    end

    def use_hint
      return ABSENT_HITNS_MESSAGE if @hints.zero?
      @hints -= 1
      show_hint

    end

    # def show_hint
    #   @unbreaked_numbers = []
    #   @secret_code.each_char do |number|
    #     unless @user_suggested_code.include?(number)
    #       @unbreaked_numbers << number
    #     end
    #   end
    #   puts @unbreaked_numbers.sample
    # end

    def show_hint
      puts @secret_code[rand(0..3)]
    end

    def show_secret_code
      puts @secret_code
    end
  end
end

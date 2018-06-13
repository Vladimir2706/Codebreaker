module Codebreaker
  ABSENT_HITNS_MESSAGE = 'Sorry, you have no hints'

  class Game
    attr_reader :attempts, :hints, :result_of_comparing

    def initialize
      @secret_code = generate_code
      @result_of_comparing = ''
      @attempts = 5
      @hints = 2
    end

    def generate_code
      (1..4).map { rand(1..6) }.join
    end

    def validate_input(input)
      raise ArgumentError, 'Type exactly 4 integer' unless input.length == 4
      raise ArgumentError, 'Type only integers from 1 to 6' if input =~ /[^1-6]/
    end

    def compare_codes(guess_code)
      guess_code.each_char.with_index do |number, index|
        if number == @secret_code[index]
          @result_of_comparing << '+'
        elsif @secret_code.include?(number)
          @result_of_comparing << '-'
        end
      end
      @result_of_comparing.chars.sort.join
    end

    def start
      if @attempts > 0
        do_attempt # add to rspec
        validate_input
        compare_codes
        show_result_of_comparing
        loose?
      end
    end

    def win?
      if @result_of_comparing = '++++' then show_win_message
      end
    end

    def loose?
      if @attempts = 0 then show_loose_message end
    end

    def show_win_message
      # Show win messahe
    end

    def show_loose_message
      # show loose message
      # exit to start_menu
    end

    def do_attempt
      @attempts -= 1
    end

    def use_hint
      return ABSENT_HITNS_MESSAGE if @hints.zero?
      @hints -= 1
      show_hint
    end

    def show_hint(guess_code)
      @unbreaked_numbers = []
      guess_code.each_char do |number|
        unless @secret_code.include?(number)
          @unbreaked_numbers << number
        end
      end
      @unbreaked_numbers.sample
    end
  end
end

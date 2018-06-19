require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    describe '#initialize' do
      before { game.generate_code }
      it 'create secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/^[1-6]{4}$/)
      end

      it 'have 7 attempts' do
        expect(game.instance_variable_get(:@attempts)).to eql 10
      end
    end

    describe '#validate_input' do
      it 'raise error if input isn\'t a digits' do
        expect { game.validate_input('aaaa') }.to raise_error(ArgumentError)
      end

      it 'raise error if input too long' do
        expect { game.validate_input('12345') }.to raise_error(ArgumentError)
      end

      it 'raise error if input too short' do
        expect { game.validate_input('123') }.to raise_error(ArgumentError)
      end
    end

    describe '#compare_codes' do
      before { game.instance_variable_set('@secret_code', '1234') }
      # around(:each) { game.compare_codes }

      context 'giving right count of "+"' do
        it 'show "+"' do
          game.instance_variable_set('@user_suggested_code', '1566')
          expect(game.compare_codes).to eql('+')
        end

        it 'show "++"' do
          game.instance_variable_set('@user_suggested_code', '1289')
          expect(game.compare_codes).to eql('++')
        end

        it 'show "+++"' do
          game.instance_variable_set('@user_suggested_code', '1239')
          expect(game.compare_codes).to eql('+++')
        end

        it 'show "++++"' do
          game.instance_variable_set('@user_suggested_code', '1234')
          expect(game.compare_codes).to eql('++++')
        end
      end

      context 'giving right count of "-"' do
        it 'show "-"' do
          game.instance_variable_set('@user_suggested_code', '7891')
          expect(game.compare_codes).to eql('-')
        end

        it 'show "--"' do
          game.instance_variable_set('@user_suggested_code', '7821')
          expect(game.compare_codes).to eql('--')
        end

        it 'show "---"' do
          game.instance_variable_set('@user_suggested_code', '7321')
          expect(game.compare_codes).to eql('---')
        end

        it 'show "----"' do
          game.instance_variable_set('@user_suggested_code', '4321')
          expect(game.compare_codes).to eql('----')
        end
      end

      context 'giving right combination of "+" and "-"' do
        it 'show "+-"' do
          game.instance_variable_set('@user_suggested_code', '1745')
          expect(game.compare_codes).to eql('+-')
        end

        it 'show "+--"' do
          game.instance_variable_set('@user_suggested_code', '4253')
          expect(game.compare_codes).to eql('+--')
        end

        it 'show "+---"' do
          game.instance_variable_set('@user_suggested_code', '3124')
          expect(game.compare_codes).to eql('+---')
        end

        it 'show "++-"' do
          game.instance_variable_set('@user_suggested_code', '1245')
          expect(game.compare_codes).to eql('++-')
        end

        it 'show "++--"' do
          game.instance_variable_set('@user_suggested_code', '1243')
          expect(game.compare_codes).to eql('++--')
        end
      end
    end

    describe '#decrease_attempts' do
      it 'decrement attempts by 1' do
        expect { game.decrease_attempts }.to change { game.instance_variable_get('@attempts') }.by(-1)
      end
    end

    describe '#use_hint' do
      context 'when hints > 0' do
        it 'decrement hints by 1' do
          allow(game).to receive(:show_hint)
          expect { game.use_hint }.to change { game.instance_variable_get('@hints') }.by(-1)
        end
      end

      context 'when hints = 0' do
        it 'raise sorry-message, if hints = 0' do
          game.instance_variable_set('@hints', 0)
          expect(game.use_hint).to eql(ABSENT_HITNS_MESSAGE)
        end
      end
    end

    describe '#show_hint' do
      before { game.instance_variable_set('@secret_code', '1234') }

      skip 'show number, which absent in guess_code' do
        expect(game.show_hint('1257')).to eql('3'). or eql('4')
      end
    end

    describe '#start' do

    end

    describe '#win?' do

    end

    describe '#loose?' do

    end

    describe '#show_win_message' do

    end

    describe '#show_loose_message' do

    end
  end
end

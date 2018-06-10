require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    describe '#initialize' do
      it 'create secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/^[1-6]{4}$/)
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

      context 'giving right count of "+"' do
        it 'show "+"' do
          expect(game.compare_codes('1789')).to eql('+')
        end

        it 'show "++"' do
          expect(game.compare_codes('1289')).to eql('++')
        end

        it 'show "+++"' do
          expect(game.compare_codes('1239')).to eql('+++')
        end

        it 'show "++++"' do
          expect(game.compare_codes('1234')).to eql('++++')
        end
      end

      context 'giving right count of "-"' do
        it 'show "-"' do
          expect(game.compare_codes('7891')).to eql('-')
        end

        it 'show "--"' do
          expect(game.compare_codes('7821')).to eql('--')
        end

        it 'show "---"' do
          expect(game.compare_codes('7321')).to eql('---')
        end

        it 'show "----"' do
          expect(game.compare_codes('4321')).to eql('----')
        end
      end

      context 'giving right combination of "+" and "-"' do
        it 'show "+-"' do
          expect(game.compare_codes('1745')).to eql('+-')
        end

        it 'show "+--"' do
          expect(game.compare_codes('4253')).to eql('+--')
        end

        it 'show "+---"' do
          expect(game.compare_codes('3124')).to eql('+---')
        end

        it 'show "++-"' do
          expect(game.compare_codes('1245')).to eql('++-')
        end

        it 'show "++--"' do
          expect(game.compare_codes('1243')).to eql('++--')
        end
      end
    end

    describe '#do_attempt' do
      it 'decrement attempts by 1' do
        expect { game.do_attempt }.to change { game.instance_variable_get('@attempts') }.by(-1)
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

      it 'show number, which absent in guess_code' do
        expect(game.show_hint('1257')).to eql('5'). or eql('7')
      end

    end
  end
end

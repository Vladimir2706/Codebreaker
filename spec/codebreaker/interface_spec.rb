require 'spec_helper'

module Codebreaker
  RSpec.describe Interface do
    let(:interface) { Interface.new }

    describe '#initialize_game' do
      before do
        allow(interface).to receive(:greeting)
        allow(interface).to receive(:start_menu)
      end
      after { interface.initialize_game }

      it { expect(interface).to receive(:greeting).with(no_args) }
      it { expect(interface).to receive(:start_menu).with(no_args) }
    end

    describe '#start_menu' do
      before do
        allow(interface).to receive(:show_start_menu)
        allow(interface).to receive(:set_user_name)
        allow(interface).to receive(:play_game)
        allow(interface).to receive(:show_score)
        allow(interface).to receive(:goodbuy)
      end
      after { interface.start_menu }

      it 'set user name' do
        allow(interface).to receive(:input).and_return('1')
        expect(interface).to receive(:set_user_name).with(no_args)
      end
      it 'start game' do
        allow(interface).to receive(:input).and_return('2')
        expect(interface).to receive(:play_game).with(no_args)
      end

      it 'show skore' do
        allow(interface).to receive(:input).and_return('3')
        expect(interface).to receive(:show_score).with(no_args)
      end

      it 'show goodbuy-message and exit game' do
        allow(interface).to receive(:input).and_return('4')
        expect(interface).to receive(:goodbuy).with(no_args)
      end
    end

    describe '#set_user_name' do

      context 'Username is correct' do
        it 'User name only from letters' do
          interface.instance_variable_set('@username', 'Tony Stark')
          expect(interface.instance_variable_get(:@username)).to match(/^[\w\s]{3,25}\z/)
        end
        it 'User name only from numbers' do
          interface.instance_variable_set('@username', '123234 4534')
          expect(interface.instance_variable_get(:@username)).to match(/^[\w\s]{3,25}\z/)
        end
        it 'User name from letters and numbers' do
          interface.instance_variable_set('@username', 'John4534')
          expect(interface.instance_variable_get(:@username)).to match(/^[\w\s]{3,25}\z/)
        end
      end

      context 'Username is wrong' do
        it 'User name is too short' do
          interface.instance_variable_set('@username', 'Be')
          expect{interface.validate_user_name('Be')}.to raise_error(ArgumentError)
        end
        it 'User name is too long' do
          interface.instance_variable_set('@username', 'Be')
          expect{ interface.validate_user_name('John128473Good12y43t213') }.to raise_error(ArgumentError)
        end
        it 'User name contain wrong symbols' do
          interface.instance_variable_set('@username', 'Jarvi$')
          expect{ interface.validate_user_name('John128473Good12y43t213') }.to raise_error(ArgumentError)
        end
      end
    end

    # describe '#game_process' do
    #   before do
    #     allow(interface).to receive(:game_menu)
    #     allow(interface).to receive(:play_game)
    #   end
    #   after { interface.game_process }
    #
    #   it { expect(interface).to receive(:game_menu).with(no_args) }
    #   it { expect(interface).to receive(:play_game).with(no_args) }
    # end

    # describe '#game_menu' do
    #   before do
    #     allow(interface).to receive(:show_game_menu)
    #     allow(interface).to receive(:set_user_name)
    #     allow(interface).to receive(:play_game)
    #     allow(interface).to receive(:start_menu)
    #   end
    #   after {interface.game_menu}
    #
    #   it 'set user name' do
    #     allow(interface).to receive(:input).and_return('1')
    #     expect(interface).to receive(:set_user_name).with(no_args)
    #   end
    #
    #   it 'start palying game' do
    #     allow(interface).to receive(:input).and_return('2')
    #     expect(interface).to receive(:play_game).with(no_args)
    #   end
    #
    #   it 'back to start menu' do
    #     allow(interface).to receive(:input).and_return('3')
    #     expect(interface).to receive(:start_menu).with(no_args)
    #   end
    # end
  end
end

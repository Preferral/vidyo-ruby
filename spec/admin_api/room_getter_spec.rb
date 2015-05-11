require 'spec_helper'

describe Vidyo::AdminApi::RoomCreator do
  include Savon::SpecHelper
  # before { allow(Resource).to receive(:where).with(created_from: params[:id]).and_return(false) }
  # it { is_expected.to respond_with 404 }
  let(:vidyo_admin_client) { Factory.build(:vidyo_admin_client) }

  before do
    allow(vidyo_admin_client).to receive(:extension_base).and_return('002')
    allow(vidyo_admin_client).to receive(:app_user_name).and_return('App')
    allow(subject).to receive(:random_extension_tail).and_return(1234567)
    allow(subject).to receive(:client).and_return(vidyo_admin_client)
    allow(subject).to receive(:name).and_return('test_room')
  end

  context 'public method' do

    describe '.call' do

      # describe 'with'

      it 'does stuff' do
        # pending # no code yet
        # raise 'Needs implementaion'
      end
    end

  end

  context 'private method' do

    describe '.create_room' do

    end

    describe '.message' do
      it 'properly orders the params (important for SOAP)' do
        message = subject.send(:message)
        expect(message.keys).to eq(["room"])
        expect(message["room"].keys).to eq(["name", "RoomType", "ownerName", "extension", "groupName", "RoomMode"])
        expect(message["room"]["RoomMode"].keys).to eq(["isLocked", "hasPin"])
      end

      it 'returns the necessary data' do
        message = subject.send(:message)
        expected_message = {
          'room' => {
            'name' => 'test_room',
            'RoomType' => 'Public',
            'ownerName' => subject.client.app_user_name,
            'extension' => '01'
          }
        }
        # expect(message)
      end
    end

    describe '.room_extension' do
      it 'includes the client extension base' do
        expect(subject.send(:room_extension)).to include(vidyo_admin_client.extension_base)
      end

      it 'memoizes a random extension tail' do
        subject.send(:room_extension)
        expect(subject.instance_variable_get(:@extension_tail)).to eq(1234567)
      end
    end

    describe '.room_type' do
      it { expect(subject.send(:room_type)).to eq('Public') }
    end

    describe '.increment_extension_tail' do
      it 'increments the extension tail' do
        subject.send(:room_extension)             # Memoize extension tail
        subject.send(:increment_extension_tail)   # Increment
        expect(subject.instance_variable_get(:@extension_tail)).to eq(1234568)
      end

      it 'stays within the limits' do
        subject.instance_variable_set(:@extension_tail, 9_999_999_999_999_999)
        subject.send(:increment_extension_tail)
        expect(subject.instance_variable_get(:@extension_tail)).to be < 9_999_999_999_999_999
      end
    end

  end
end

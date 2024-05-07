# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name_or_email' do
    context 'when a name is registered' do
      it 'returns a name' do
        alice = create(:user, name: 'アリス')
        expect('アリス').to eq alice.name_or_email
      end
    end

    context 'when a name is not registered' do
      it 'returns a email' do
        nameless = create(:user, email: 'nameless@example.com', name: '')
        expect('nameless@example.com').to eq nameless.name_or_email
      end
    end
  end
end

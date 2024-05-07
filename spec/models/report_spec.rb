# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  describe '#editable?' do
    before do
      @alice = create(:user, name: 'アリス')
      @alice_report = create(:report, user: @alice)
    end

    context 'as a report author' do
      it 'is editable' do
        expect(@alice_report.editable?(@alice)).to be_truthy
      end
    end

    context 'as a not report author' do
      it 'is not editable' do
        bob = create(:user, name: 'ボブ')
        expect(@alice_report.editable?(bob)).to be_falsey
      end
    end
  end

  describe '#created_on' do
    it 'returns a date' do
      report = create(:report)
      expect(report.created_on).to eq Date.current
    end
  end
end

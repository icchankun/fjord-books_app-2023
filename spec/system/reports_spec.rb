# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :system do
  describe 'Reports CRUD' do
    before do
      alice = create(:user, email: 'alice@example.com', name: 'アリス', password: 'alice-password')
      @alice_report = create(:report, user: alice)

      visit root_path

      fill_in 'Eメール', with: 'alice@example.com'
      fill_in 'パスワード', with: 'alice-password'
      click_on 'ログイン'

      expect(page).to have_content 'ログインしました。'
    end

    scenario 'visiting the index' do
      visit reports_path
      expect(page).to have_selector 'h1', text: '日報'
    end

    scenario 'creating a report' do
      visit reports_path
      click_on '日報の新規作成'

      fill_in 'タイトル', with: '初めての日報'
      fill_in '内容', with: <<~TEXT
        参考にした日報のURLを書きました。
        http://localhost:3000/reports/#{@alice_report.id}
      TEXT

      expect do
        click_on '登録する'
        assert_text '日報が作成されました。'
      end.to change { Report.count }.by(1)

      expect(@alice_report.mentioned_reports.count).to eq 1
      expect('初めての日報').to eq @alice_report.mentioned_reports.last.title

      click_on '日報の一覧に戻る'
    end

    scenario 'updating a report' do
      visit report_path(@alice_report)
      click_on 'この日報を編集'

      fill_in 'タイトル', with: '最後の日報'
      fill_in '内容', with: <<~TEXT
        自分の日報のURLを書きました。
        http://localhost:3000/reports/#{@alice_report.id}
      TEXT
      click_on '更新する'
      expect(page).to have_content '日報が更新されました。'

      expect(@alice_report.mentioned_reports.count).to eq 0

      click_on '日報の一覧に戻る'
    end

    scenario 'destroying a report' do
      visit report_path(@alice_report)

      expect do
        click_on 'この日報を削除'
        expect(page).to have_content '日報が削除されました。'
      end.to change { Report.count }.by(-1)
    end
  end
end

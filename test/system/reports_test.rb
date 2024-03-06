# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:alice)

    visit root_url

    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'

    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '初めての日報'
    fill_in '内容', with: <<~TEXT
      参考にした日報のURLを書きました。
      http://localhost:3000/reports/#{@report.id}
    TEXT
    click_on '登録する'

    assert ['初めての日報'], @report.mentioned_reports.pluck(:title)

    assert_text '日報が作成されました。'
    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: '最後の日報'
    fill_in '内容', with: <<~TEXT
      この日報のURLを書きました。
      http://localhost:3000/reports/#{@report.id}
    TEXT
    click_on '更新する'

    assert @report.mentioning_reports.empty?

    assert_text '日報が更新されました。'
    click_on '日報の一覧に戻る'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
  end
end

# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioning, class_name: 'Report'
  belongs_to :mentioned, class_name: 'Report'

  validates :mentioning_id, presence: true, uniqueness: { scope: :mentioned_id }
  validates :mentioned_id, presence: true

  def self.save_only_mentioning_reports(report)
    mentioning_report_ids_diff = report.fetch_mentioning_report_ids_diff
    add_ids = mentioning_report_ids_diff[:added_ids]
    remove_ids = mentioning_report_ids_diff[:removed_ids]

    report.add_mentions(add_ids) if add_ids
    report.remove_mentions(remove_ids) if remove_ids
  end
end

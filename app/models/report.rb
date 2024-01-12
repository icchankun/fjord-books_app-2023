# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :active_mentions, class_name: 'Mention', foreign_key: 'mentioning_id', inverse_of: 'mentioning', dependent: :destroy
  has_many :passive_mentions, class_name: 'Mention', foreign_key: 'mentioned_id', inverse_of: 'mentioned', dependent: :destroy
  has_many :mentioning_reports, through: :active_mentions, source: :mentioned
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning

  validates :title, presence: true
  validates :content, presence: true

  after_save :save_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def save_mentions
    mentioning_report_ids_diff = fetch_mentioning_report_ids_diff
    add_ids = mentioning_report_ids_diff[:added_ids]
    remove_ids = mentioning_report_ids_diff[:removed_ids]

    add_mentions(add_ids)
    remove_mentions(remove_ids)
  end

  def fetch_mentioning_report_ids_diff
    report_ids_in_content = extract_report_ids_in_content
    mentioning_report_ids = mentioning_reports.map(&:id)

    {
      added_ids: report_ids_in_content - mentioning_report_ids,
      removed_ids: mentioning_report_ids - report_ids_in_content
    }
  end

  def add_mentions(added_ids)
    added_ids.each { |id| active_mentions.create(mentioned_id: id) }
  end

  def remove_mentions(removed_ids)
    active_mentions.where(mentioned_id: removed_ids).destroy_all
  end

  def extract_report_ids_in_content
    urls_in_content = URI.extract(content, ['http'])
    urls_in_content.map { |url_in_content| url_in_content.scan(%r{http://localhost:3000/reports/(\d+)}) }.flatten.map(&:to_i)
  end
end

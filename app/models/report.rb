# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :active_mentions, class_name: 'Mention', foreign_key: 'mentioning_id', inverse_of: 'mentioning', dependent: :destroy
  has_many :passive_mentions, class_name: 'Mention', foreign_key: 'mentioned_id', inverse_of: 'mentioned', dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end
end

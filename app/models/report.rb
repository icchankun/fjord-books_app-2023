# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  validates :title, :body, presence: true
end

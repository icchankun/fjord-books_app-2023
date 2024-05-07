# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { '初めての日報' }
    content { 'よろしくお願いします。' }
    association :user
  end
end

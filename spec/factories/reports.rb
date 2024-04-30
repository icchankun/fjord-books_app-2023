# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { '初めての日報' }
    content { 'よろしくお願いします。' }
    created_at { Time.current }
    association :user
  end
end

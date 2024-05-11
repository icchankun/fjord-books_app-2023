# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@example.com" }
    name { 'マイク' }
    password { 'password' }
  end
end

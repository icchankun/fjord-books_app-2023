# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'example@example.com' }
    name { 'マイク' }
    password { 'password' }

    trait :alice do
      email { 'alice@example.com' }
      name { 'アリス' }
    end

    trait :bob do
      email { 'bob@example.com' }
      name { 'ボブ' }
    end

    trait :nameless do
      email { 'nameless@example.com' }
      name { '' }
    end
  end
end

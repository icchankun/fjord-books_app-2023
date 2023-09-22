# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  validate :correct_avatar_mime_type

  private

  def correct_avatar_mime_type
    return unless avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png image/gif])

    avatar.purge
    errors.add(:avatar, :wrong_format)
  end
end

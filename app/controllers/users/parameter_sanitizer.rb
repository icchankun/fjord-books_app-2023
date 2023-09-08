# frozen_string_literal: true

class Users::ParameterSanitizer < Devise::ParameterSanitizer
  ADDITIONAL_PERMITTED_ATTRIBUTES = {
    sign_in: %i[email],
    sign_up: %i[email],
    account_update: %i[email address introduction zip_code]
  }.freeze

  def initialize(*)
    super

    ADDITIONAL_PERMITTED_ATTRIBUTES.each_pair do |action, keys|
      permit(action, keys:)
    end
  end
end

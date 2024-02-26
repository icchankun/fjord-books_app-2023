# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_email' do
    assert_equal 'アリス', users(:alice).name_or_email
    assert_equal 'bob@example.com', users(:bob).name_or_email
  end
end

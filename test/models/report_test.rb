# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    assert reports(:alice).editable?(users(:alice))
    assert_not reports(:alice).editable?(users(:bob))
  end

  test 'created_on' do
    assert_equal '2024-01-01', reports(:alice).created_on.to_s
  end
end

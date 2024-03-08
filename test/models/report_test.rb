# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    assert reports(:alice).editable?(users(:alice))
    assert_not reports(:alice).editable?(users(:bob))
  end

  test 'created_on' do
    travel_to Time.zone.local(2024, 1, 1, 0, 0, 0)
    reports(:alice).created_at = Time.current
    assert_equal Date.new(2024, 1, 1), reports(:alice).created_on
  end
end

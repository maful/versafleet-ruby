# frozen_string_literal: true

require "test_helper"

class VersafleetTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Versafleet::VERSION
  end
end

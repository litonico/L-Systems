require './lib/lsystem'
require 'minitest/autorun'

class LSystemTest < MiniTest::Test
  def setup
    @lsystem = LSystem.new "A", "A" => "AB", "B" => "A"
  end

  def test_rewrites_string
    assert_equal "AB", @lsystem.step.state
    assert_equal "ABA", @lsystem.step.state
    assert_equal "ABAAB", @lsystem.step.state
  end
end

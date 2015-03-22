require './lib/turtle'
require 'minitest/autorun'

class TurtleTest < MiniTest::Spec
  def setup
    @turtle = Turtle.new nil, "A" => nil
  end

  def test_turtle_can_raise_pen
    @turtle.send(:pen_up)
    @turtle.drawing.must_equal false
  end

  def test_turtle_can_lower_pen
    @turtle.send(:pen_down)
    @turtle.drawing.must_equal true
  end

  def test_turtle_can_move_forward
    @turtle.pos.x.must_equal 0
    @turtle.send(:forward)
    @turtle.pos.x.must_equal 1
    @turtle.send(:forward, 0.5)
    @turtle.pos.x.must_equal 1.5
  end

  def test_turtle_can_move_backward
    @turtle.pos.x.must_equal 0
    @turtle.send(:backward)
    @turtle.pos.x.must_equal (-1)
    @turtle.send(:backward, 0.5)
    @turtle.pos.x.must_equal (-1.5)
  end

  def test_turtle_can_turn_left
    @turtle.send(:left, 45)
    @turtle.direction.must_equal 45
    @turtle.send(:forward)
    @turtle.pos.x.must_be_within_epsilon (Math.sqrt(2)/2)
    @turtle.pos.y.must_be_within_epsilon (Math.sqrt(2)/2)
  end

  def test_turtle_can_turn_right
    @turtle.send(:right, 45)
    @turtle.direction.must_equal (-45)
    @turtle.send(:forward)
    @turtle.pos.x.must_be_within_epsilon (Math.sqrt(2)/2)
    @turtle.pos.y.must_be_within_epsilon (-1 * Math.sqrt(2)/2)
  end

  def test_turning_wraps_around
    @turtle.send(:left, 540)
    @turtle.direction.must_equal 180
  end

  def test_turtle_interprets_hashes
    s = "A"
    @turtle = Turtle.new s, "A" => :pen_up
    @turtle.exec("A")
    @turtle.drawing.must_equal false
  end

  def test_turtle_step_wraps_around
    s = "AB"
    @turtle = Turtle.new s, "A" => :pen_up, "B" => :pen_down
    @turtle.step
    @turtle.drawing.must_equal false
    @turtle.current_index.must_equal 1
    @turtle.step
    @turtle.drawing.must_equal true
    @turtle.current_index.must_equal 0
  end

  def test_pushing_state
    @turtle.send(:push)
    @turtle.stack.must_equal [[Pos.new(0,0), 0]]
    @turtle.send(:forward)
    @turtle.send(:push)
    @turtle.stack.must_equal [[Pos.new(0,0), 0], [Pos.new(1,0), 0]]
  end

  def test_popping_state
    @turtle.send(:push)
    @turtle.stack.must_equal [[Pos.new(0,0), 0]]
    @turtle.send(:forward)
    @turtle.send(:pop)
    @turtle.position.must_equal Pos.new(0,0)
    @turtle.stack.must_equal []
  end

  def test_exec_multiple_args
    s = "1.[0,]0"
    @turtle = Turtle.new s, "1" => :forward,
                            "0" => :forward,
                            "[" => [:left, 60],
                            "]" => [:right, 60],
                            "." => :push,
                            "," => :pop
    @turtle.step.step.step.step
    @turtle.direction.must_equal 60
    @turtle.step.step.step
    @turtle.direction.must_equal (-60)
  end

  def test_halt_after_done_flag
    s = "111111"
    @turtle = Turtle.new s, "1" => :forward
    @turtle.stop_after_done!
    @turtle.step.step.step.step.step.step.step.step
    @turtle.position.must_equal Pos.new(6, 0)
  end

end

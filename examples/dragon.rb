require "./lib/turtle"
require "./lib/lsystem"
require "./lib/draw"

dragon = LSystem.new "XY",
  "X" => "X+YF+",
  "Y" => "-FX-Y",
  "F" => "F",
  "+" => "+",
  "-" => "-"
dragon.step.step.step.step.step.step.step


turtle = Turtle.new dragon.state, "F" => [:forward, 0.2],
                                   "+" => [:left, 90],
                                   "-" => [:right, 90],
                                   "X" => :nop,
                                   "Y" => :nop
turtle.send(:left, 90)
turtle.stop_after_done!

TurtleSimulation.new(turtle).run

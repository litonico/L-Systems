require "./lib/draw"
require "./lib/turtle"
require "./lib/lsystem"

spiral = LSystem.new "S",
  "S" => "S+L",
  "L" => "LL",
  "+" => "+",
  "," => ",",
  "." => "."
spiral.step.step.step.step.step.step


turtle = Turtle.new spiral.state,
  "S" => :nop,
  "L" => [:forward, 0.2],
  "+" => [:left, 137.5],
  "." => :push,
  "," => :pop

turtle.send(:left, 90)
turtle.stop_after_done!

TurtleSimulation.new(turtle).run

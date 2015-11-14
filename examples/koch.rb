require "./lib/draw"
require "./lib/turtle"
require "./lib/lsystem"

koch = LSystem.new "K",
  "K" => "K+K--K+K",
  "+" => "+",
  "-" => "-"
koch.step.step

turtle = Turtle.new koch.state,
  "K" => [:forward, 0.7],
  "+" => [:right, 45],
  "-" => [:left, 45],
  "[" => :push,
  "]" => :pop
turtle.send(:left, 180)
turtle.stop_after_done!

TurtleSimulation.new(turtle).run

require "./lib/draw"
require "./lib/turtle"
require "./lib/lsystem"

juniper = LSystem.new "F",
  "F" => "F[+F]F[-F][F]",
  "[" => "[",
  "]" => "]",
  "+" => "+",
  "-" => "-"
juniper.step.step.step.step


turtle = Turtle.new juniper.state, "F" => [:forward, 0.2],
                                   "+" => [:right, 20],
                                   "-" => [:left, 20],
                                   "[" => :push,
                                   "]" => :pop
turtle.send(:left, 90)
turtle.stop_after_done!

TurtleSimulation.new(turtle).run

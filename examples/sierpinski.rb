require "./lib/turtle"
require "./lib/lsystem"
require "./lib/draw"

sierpinski = LSystem.new "A", "A" => "B-A-B",
                           "B" => "A+B+A",
                           "+" => "+",
                           "-" => "-"
sierpinski.step.step.step.step.step.step


turtle = Turtle.new sierpinski.state, "A" => [:forward, 0.1],
                                      "B" => [:forward, 0.1],
                                      "+" => [:right, 60],
                                      "-" => [:left, 60]
turtle.send(:left, 180) # Get pointed in the right direction
turtle.stop_after_done!
TurtleSimulation.new(turtle).run

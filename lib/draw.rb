require "graphics"
require "./lib/turtle"

Line = Struct.new :start, :fin

class TurtleSimulation < Graphics::Simulation
  WINSIZE = 800
  attr_accessor :simulation

  def initialize turtle
    super WINSIZE, WINSIZE, 16, "Turtle Graphics"
    @turtle = turtle
    @offset = Pos.new(WINSIZE/2, WINSIZE/2-100)
    @pos = @offset
    @prev_pos = @pos
    @lines = []
  end

  def turtle_step
    @prev_pos = @pos
    stack = @turtle.stack.clone
    @turtle.step
    @pos = Pos.new(@turtle.position.x*100+@offset.x,
                   @turtle.position.y*100+@offset.y)
    # If the stack changed, the turtle jumps to a new position,
    # and no line is drawn
    if stack != @turtle.stack
      @prev_pos = @pos
    end
  end

  def update dt
    unless @prev_pos == @pos
      @lines << Line.new(@prev_pos, @pos)
    end
  end

  def draw dt
    clear :white
    @lines.each do |line|
      fat_line(7, line.start.x, line.start.y,
                  line.fin.x, line.fin.y, :black)
    end
  end

  def initialize_keys
    super

    add_key_handler(:SPACE) {
      turtle_step
    }
  end
end

def fat_line thickness, x1, y1, x2, y2, color
  t = thickness/2
  distance = Math.sqrt((x1-x2)**2 + (y2 - y1)**2)
  dx = (y2-y1)/distance * t
  dy = (x2-x1)/distance * t * -1
  points = [
    [x1+dx, y1+dy],
    [x2+dx, y2+dy],
    [x2-dx, y2-dy],
    [x1-dx, y1-dy]
  ]
  polygon(*points, color)
end

if __FILE__ == $0
  s = "11.[1.[0,]0,]1.[0,]0"
  turtle = Turtle.new s,
    "1" => :forward,
    "0" => :forward,
    "[" => [:left, 45],
    "]" => [:right, 45],
    "." => :push,
    "," => :pop
  turtle.send(:left, 90) # Get pointed in the right direction
  turtle.stop_after_done!

  TurtleSimulation.new(turtle).run
end

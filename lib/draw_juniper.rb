require "gosu"
require "../lib/turtle"
require "../lib/lsystem"

Line = Struct.new :start, :fin

class TurtleWindow < Gosu::Window
  W = Gosu::Color::WHITE
  B = Gosu::Color::BLACK

  def initialize turtle, winsize
    super winsize, winsize, false
    self.caption = "Turtle Graphics"
    @turtle = turtle
    @winsize = winsize
    @dt = 0
    @offset = Pos.new(winsize/2, winsize/2+300)
    @pos = @offset
    @prev_pos = @pos
    @lines = []
  end

  def turtle_step
    @prev_pos = @pos
    stack = @turtle.stack.clone
    @turtle.step
    @pos = Pos.new(@turtle.position.x*100+@offset.x,
                   @turtle.position.y*100+@offset.y) # Y-axis is flipped
    # If the stack changed, the turtle jumps to a new position,
    # and no line is drawn
    if stack != @turtle.stack
      @prev_pos = @pos
    end
  end

  def draw_turtle_string_location
    font = Gosu::Font.new(self, "monaco", 10)
    font.draw(@turtle.str, 5, 10, 0, 1, 1, B)
    arrow = " "*@turtle.current_index + "\u2191"
    font.draw(arrow, 4, 20, 0, 1, 1, Gosu::Color::RED)
  end

  def draw_background color
    draw_quad(0, 0, color,
              0, @winsize, color,
              @winsize, 0, color,
              @winsize, @winsize, color)
  end

  def update
    unless @prev_pos == @pos
      @lines << Line.new(@prev_pos, @pos)
    end
    self.turtle_step
    @dt += 1
  end

  def draw
    draw_background W
    @lines.each do |line|
      draw_fat_line(2, line.start.x, line.start.y, B,
                    line.fin.x, line.fin.y, B)
    end
    draw_turtle_string_location
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

end

def draw_fat_line thickness,
                  x1, y1, c1,
                  x2, y2, c2,
                  z = 0, mode = :default
  t = thickness/2
  distance = Math.sqrt((x1-x2)**2 + (y2 - y1)**2)
  dx = (y2-y1)/distance * t
  dy = (x2-x1)/distance * t * -1
  draw_quad(x1+dx, y1+dy, c1,
            x1-dx, y1-dy, c1,
            x2+dx, y2+dy, c2,
            x2-dx, y2-dy, c2,
            z, mode)
end

def draw_circle px, py, radius, color, steps=16
  dd = 2*Math::PI/steps
  (0..2*Math::PI).step(dd).each do |d|
    draw_triangle(px, py, color,
                  px+Math.cos(d)*radius, py+Math.sin(d)*radius, color,
                  px+Math.cos(d+dd)*radius, py+Math.sin(d+dd)*radius, color)
  end
end


juniper = LSystem.new "F", "F" => "F[+F]F[-F][F]",
                           "[" => "[",
                           "]" => "]",
                           "+" => "+",
                           "-" => "-"
juniper.step.step.step.step


turtle = Turtle.new juniper.state, "F" => [:forward, 0.2],
                                   # Due to dumb y-axis stuff, screen-left
                                   # is *actual* right. We're doing this for
                                   # looks, not correctness.
                                   "+" => [:left, 20],
                                   "-" => [:right, 20],
                                   "[" => :push,
                                   "]" => :pop
turtle.send(:left, -90) # Get pointed in the right direction
turtle.stop_after_done!

window = TurtleWindow.new turtle, 800
window.show

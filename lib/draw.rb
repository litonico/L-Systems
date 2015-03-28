require "gosu"
require "../lib/turtle"

Line = Struct.new :start, :fin

class TurtleWindow < Gosu::Window
  W = Gosu::Color::WHITE
  B = Gosu::Color::BLACK

  def initialize turtle, winsize
    super winsize, winsize, false, 66.6
    self.caption = "Turtle Graphics"
    @turtle = turtle
    @winsize = winsize
    @dt = 0
    @offset = Pos.new(winsize/2, winsize/2+100)
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
    # if the stack changed, the turtle jumps to a new position
    if stack != @turtle.stack
      @prev_pos = @pos
    end
  end

  def draw_turtle_string_location
    font = Gosu::Font.new(self, "monaco", 50)
    font.draw(@turtle.str, 30, 10, 0, 1, 1, B)
    arrow = " "*@turtle.current_index + "\u2191"
    font.draw(arrow, 4, 55, 0, 1, 1, Gosu::Color::RED)
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
    @dt += 1
  end

  def draw
    draw_background W
    @lines.each do |line|
      draw_line(line.start.x, line.start.y, B,
                line.fin.x, line.fin.y, B)
    end
    draw_turtle_string_location
  end

  def button_down id
    close if id == Gosu::KbEscape
    self.turtle_step if id == Gosu::KbSpace
  end

end

def draw_fat_line x1, y1, c1,
                  x2, y2, c2,
                  z = 0, mode = :default
end

def draw_circle px, py, radius, color, steps=16
  dd = 2*Math::PI/steps
  (0..2*Math::PI).step(dd).each do |d|
    draw_triangle(px, py, color,
                  px+Math.cos(d)*radius, py+Math.sin(d)*radius, color,
                  px+Math.cos(d+dd)*radius, py+Math.sin(d+dd)*radius, color)
  end
end


s = "11.[1.[0,]0,]1.[0,]0"
turtle = Turtle.new s, "1" => :forward,
                       "0" => :forward,
                       # due to dumb y-axis stuff, screen-left
                       # is *actual* right. We're doing this for
                       # looks, not correctness.
                       "[" => [:right, 45],
                       "]" => [:left, 45],
                       "." => :push,
                       "," => :pop
turtle.send(:left, -90) # Get pointed in the right direction
turtle.stop_after_done!

window = TurtleWindow.new turtle, 800
window.show

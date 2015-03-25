require "gosu"
require "../lib/turtle"

Line = Struct.new :start, :fin

class TurtleWindow < Gosu::Window
  W = Gosu::Color::WHITE
  B = Gosu::Color::BLACK

  def initialize turtle, scale
    super scale, scale, false, 66.6
    self.caption = "Repelling particles simulation"
    @turtle = turtle
    @scale = scale
    @dt = 0
    @offset = Pos.new(scale/2, scale/2)
    @pos = @offset
    @prev_pos = @pos
    @lines = []
  end

  def turtle_step
    @prev_pos = @pos
    @turtle.step
    @pos = Pos.new(@turtle.position.x*100+@offset.x,
                   @turtle.position.y*100+@offset.y) # Y-axis is flipped
  end

  def update
    @lines << Line.new(@prev_pos, @pos)
    @dt += 1
  end

  def draw_frame_number
    Gosu::Font.new(self, "arial", 10).draw(@dt, 10, 10, 0)
  end

  def draw_turtle_string_location
    Gosu::Font.new(self, "arial", 10).draw(@turtle.pos, 30, 10, 0)
  end

  def draw_background color
    draw_quad(0, 0, color,
              0, @scale, color,
              @scale, 0, color,
              @scale, @scale, color)
  end

  def draw
    draw_background W
    @lines.each do |line|
      draw_line(line.start.x, line.start.y, B,
                line.fin.x, line.fin.y, B)
    end
    draw_frame_number
    draw_turtle_string_location
  end

  def button_down id
    close if id == Gosu::KbEscape
    self.turtle_step if id == Gosu::KbSpace
  end

end


s = "1.[0,]0"
turtle = Turtle.new s, "1" => :forward,
                       "0" => :forward,
                       "[" => [:left, 60],
                       "]" => [:right, 60],
                       "." => :push,
                       "," => :pop
turtle.stop_after_done!

window = TurtleWindow.new turtle, 800

window.show

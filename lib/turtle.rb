Pos = Struct.new(:x, :y)

class Turtle
  attr_reader :current_index, :pos, :direction, :drawing, :stack, :str
  def initialize str, rules
    @str = str
    @rules = rules
    @drawing = true
    @current_index = 0
    @pos = Pos.new(0, 0)
    @direction = 0
    @stack = []
    @repeat = true
  end

  def stop_after_done!
    @repeat = false
  end

  def position
    @pos
  end

  def pen_up
    @drawing = false
    self
  end

  def pen_down
    @drawing = true
    self
  end

  def nop
    self
  end

  def left degrees=45
    @direction += degrees % 360
    self
  end

  def right degrees=45
    @direction -= degrees % 360
    self
  end

  def forward distance=1
    @pos.x += Math.cos(@direction * Math::PI/180.0)*distance
    @pos.y += Math.sin(@direction * Math::PI/180.0)*distance
    self
  end

  def backward distance=1
    self.forward (-1*distance)
  end

  def push
    stack << [Pos.new(@pos.x, @pos.y), @direction]
    self
  end

  def pop
    t = stack.pop
    @pos = t[0]
    @direction = t[1]
    self
  end

  def halt
    @halt = true
    self
  end

  def exec s
    self.send(*@rules[s])
    self
  end

  def step
    unless @halt
      exec(@str[@current_index])
      if ( @current_index + 1 ) >= @str.length && !@repeat
        self.halt
      else
        @current_index = ( @current_index + 1 ) % @str.length
        self
      end
    else
      self
    end
  end

end

class LSystem
  attr_reader :state

  def initialize state, rules
    @state = state
    @rules = rules
  end

  def step
    @state = @state.split("")
                   .map {|s| @rules[s] }
                   .join
    self
  end
end

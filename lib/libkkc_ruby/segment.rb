module LibKKC
  class Segment
    attr_accessor :output, :input

    def initialize(output, input)
      @output = output
      @input = input
    end
  end
end

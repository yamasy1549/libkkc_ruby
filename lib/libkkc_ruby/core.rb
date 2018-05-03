module LibKKC
  class Core
    #
    # 第1候補を文字列で返す
    #
    # convert(String)
    # #=> String
    #
    def convert(sentence, boundary: nil)
      convert_n_best(sentence, boundary: boundary).first
    end

    #
    # 第n候補までを文字列の配列で返す
    #
    # convert_n_best(String, Integer)
    # #=> [String, ...]
    #
    def convert_n_best(sentence, n_best: 1, boundary: nil)
      segments = segmentalize_n_best(sentence, n_best: n_best, boundary: boundary)
      segments.map do |segment|
        segment.map(&:output).join
      end
    end

    #
    # 第1候補をSegmentの配列で返す
    #
    # segmentalize(String)
    # #=> [Segment, ...]
    #
    def segmentalize(sentence, boundary: nil)
      segmentalize_n_best(sentence, boundary: boundary).first
    end

    #
    # 第n候補までをSegmentの配列の配列で返す
    #
    # segmentalize_n_best(String, Integer)
    # #=> [[Segment, ...], ...]
    #
    def segmentalize_n_best(sentence, n_best: 1, boundary: nil)
      command = "echo '#{sentence} #{n_best} #{boundary}' | kkc"

      run_command(command) do |kkc_io|
        kkc_stdout = kkc_io.read
        extract_segments(kkc_stdout)
      end
    end

    private

    def run_command(cmd, &block)
      return IO.popen(cmd, &block) if block_given?

      `#{cmd}`.chomp
    end


    def extract_segments(stdout)
      # e.g.
      # >> 0: <キラキラ/きらきら><ときめ/ときめ><い/い><たら/たら>
      # 1: <きらきら/きらきら><ときめ/ときめ><い/い><たら/たら>

      stdout.scan(/\d+:\s(?<row_segments>.*)$/).flatten.map do |row_segment|
        row_segment.scan(/<(?<output>.+?)\/(?<input>.+?)>/).map do |(output, input)|
          Segment.new(output, input)
        end
      end
    end
  end
end

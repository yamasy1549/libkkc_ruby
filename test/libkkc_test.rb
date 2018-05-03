require File.expand_path('../test_helper', __FILE__)

class LibKKCTest < Minitest::Test
  def setup
    @kkc = LibKKC::Core.new
  end

  # -----
  # LibKKC#convert
  # -----

  def test_convert
    converted = @kkc.convert('にじいろにかがやく')

    assert_equal '虹色に輝く', converted
  end

  def test_convert_with_boundary
    converted = @kkc.convert('ゆめをみつけにゆこう', boundary: [0, 2, 3, 6, 7, 10])

    assert_equal '夢を見つけにゆこう', converted
  end

  # -----
  # LibKKC#convert_n_best
  # -----

  def test_convert_n_best
    converted = @kkc.convert_n_best('きらきらときめいたら', n_best: 2)
    n_best = [
      'キラキラときめいたら',
      'きらきらときめいたら'
    ]

    assert_equal n_best.size, converted.size
  end

  def test_convert_n_best_with_boundary
    converted = @kkc.convert_n_best('おもいのままたのしんじゃえ', n_best: 2, boundary: [0, 3, 6, 9])
    n_best = [
      '思いのまま楽しんじゃ絵',
      '思いのまま楽しんじゃえ'
    ]

    assert_equal n_best, converted
  end

  # -----
  # LibKKC#segmentalize
  # -----

  def test_segmentalize
    segmentalized = @kkc.segmentalize('きみとなら')
    segments = [
      { input: 'きみと', output: '公人' },
      { input: 'なら', output: 'なら' }
    ]

    assert_equal segments[0][:input],  segmentalized[0].input
    assert_equal segments[0][:output], segmentalized[0].output
    assert_equal segments[1][:input],  segmentalized[1].input
    assert_equal segments[1][:output], segmentalized[1].output
  end

  def test_segmentalize_with_boundary
    segmentalized = @kkc.segmentalize('どこまでもゆけるよ', boundary: [0, 5])
    segments = [
      { input: 'どこまでも', output: 'どこまでも' },
      { input: 'ゆけ', output: '行け' },
      { input: 'る', output: 'る' },
      { input: 'よ', output: 'よ' }
    ]

    assert_equal segments.size, segmentalized.size
  end

  # -----
  # LibKKC#segmentalize_n_best
  # -----

  def test_segmentalize_n_best
    segmentalized = @kkc.segmentalize_n_best('おわらないものがたり', n_best: 2)
    segments = [
      [
        { input: 'おわ', output: '終わ' },
        { input: 'ら', output: 'ら' },
        { input: 'な', output: 'な' },
        { input: 'い', output: 'い' },
        { input: 'ものがたり', output: '物語' }
      ],
      [
        { input: 'おわ', output: '終' },
        { input: 'ら', output: 'ら' },
        { input: 'な', output: 'な' },
        { input: 'い', output: 'い' },
        { input: 'ものがたり', output: '物語' }
      ]
    ]

    assert_equal segments[0].size, segmentalized[0].size
    assert_equal segments[1].size, segmentalized[1].size
  end

  def test_segmentalize_n_best_with_boundary
    segmentalized = @kkc.segmentalize_n_best('すたーとしよう', n_best: 2, boundary: [0, 4])
    segments = [
      [
        { input: 'すたーと', output: 'スタート' },
        { input: 'しよう', output: 'しよう' }
      ],
      [
        { input: 'すたーと', output: 'スタート' },
        { input: 'しよう', output: '仕様' }
      ]
    ]

    assert_equal segments.size, segmentalized.size
  end

  # プリパラドリームパレード
end

# libkkc_ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'libkkc_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install libkkc_ruby

## Usage

```ruby
@kkc = LibKKC::Core.new

@kkc.convert('にじいろにかがやく')
#=> '虹色に輝く'

@kkc.convert_n_best('おもいのままたのしんじゃえ', n_best: 2, boundary: [0, 3, 6, 9])
#=> [
#     '思いのまま楽しんじゃ絵',
#     '思いのまま楽しんじゃえ'
#   ]

@kkc.segmentalize_n_best('すたーとしよう', n_best: 2, boundary: [0, 4])
#=> [
#     [
#       #<LibKKC::Segment:0x00005610f9558380 @output="スタート" @input="すたーと">,
#       #<LibKKC::Segment:0x00005610f9558330 @output="しよう" @input="しよう">
#     ],
#     [
#       #<LibKKC::Segment:0x00005610f9558308 @output="スタート" @input="すたーと">,
#       #<LibKKC::Segment:0x00005610f9558290 @output="仕様" @input="しよう">
#     ]
#   ]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yamasy1549/libkkc_ruby.

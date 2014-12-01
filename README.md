# Nifty::Variants

If you are familiar with variants from a nice language like Haskell try this.

If you don't know what variants are [start here](http://youtu.be/ZQkIWWTygio)B1;2802;0c

**NOTE** Nifty::Variants makes use of Refinements which weren't introduced until
Ruby 2.1 and as a result no Ruby below 2.1 is supported. You're welcome to write
a fancy shim, but I don't recommend it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nifty-variants'
```

And then execute:

    $ bundle install -j2

## Usage

`nifty-variants` makes use of Refinements which were introduced in Ruby 2.1.
In order to use it in your class or module simply use it.

```ruby
class OrderDispatch
  using Nifty::Variants

  def shipit!(order)
    cases order,
      digital: ->(o) { o.email! },
      delivery: ->(o) { o.deliver! },
      else: ->(o) { move_to_error_queue(o) }
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/nifty-variants/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

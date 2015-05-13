# FuzzyRecord

FuzzyRecord searches through active records using fuzzy matchers and orders them based on FuzzyString.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fuzzy_record'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fuzzy_record

## Usage

To use for any active record model:

```ruby
    $ Model.fuzzy_search('string')
```

It will search through your model for records where the first of these that exists
(:fuzzy_name, :ident, :name) fuzzy_matches and order it by best match

Alternatively you can use a hash where the field to be searched is the key:

```ruby
    $ Model.fuzzy_search(title: 'string')
```

To make this the default behavior for your model simply add the definition:

```ruby
    $ def self.fuzzy_search(str) super(title: str) end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fuzzy_record/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Author
-------

* Chris Moody

License
-------

This is free software released into the public domain.

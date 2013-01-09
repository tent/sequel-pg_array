# Sequel::Plugins::PGArray

Sequel ORM Plugin for serializing columns as Postges Arrays build atop `Sequel::Plugins::Serialization`.

## Installation

Add this line to your application's Gemfile:

    gem 'sequel-pg_array'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-pg_array

## Usage

```ruby
require 'sequel-pg_array'

DB = Sequel.connect(ENV['DATABASE_URL'])

class Person < Sequel::Model(:people)
  plugin :serialization
  serialize_attributes :pg_array, :interests, :colors
end

unless DB.table_exists?(:people)
  DB.create_table :people do
    primary_key :id
    column :interests, "text[]", :default=>"{}"
    column :colors, "text[]", :default=>"{}"
  end
  Person.columns # load columns
end


person = Person.create(
  :interests => %w( space travel deep sea diving ),
  :colors => %w( red white )
)
person.interests # => ['space travel', 'deep sea diving']
person.colors # => ['red', 'white']
person.colors << 'blue'
person.id # => 1
person.save

person = Person.first(:id => 1)
person.colors # => ['red', 'white', 'blue']
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

require "sequel/plugins/pg_array/version"
require 'sequel/plugins/serialization'

module Sequel
  module Plugins
    module PGArray
      module Serialize
        def self.call(value)
          return if value.nil?
          "{#{value.map(&:to_s).map(&:inspect).join(',')}}"
        end
      end

      module Deserialize
        def self.call(value)
          return if value.nil?
          value[1..-2].split(',').map { |v| v[0,1] == '"' ? v[1..-2] : v  }
        end
      end
    end

    Serialization.register_format(:pg_array, PGArray::Serialize, PGArray::Deserialize)
  end
end

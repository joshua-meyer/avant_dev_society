module JoshsHashStructures
  class Base
    attr_reader :hash_map, :mod_reducer
    MOD_MULTIPLIER = 2

    def initialize
      @hash_map = []
      @mod_reducer = 5
    end

    def []=(some_key, some_value)
      lookup_value = hash_something(some_key)
      @hash_map[lookup_value] = [] if @hash_map[lookup_value].nil?
      @hash_map[lookup_value] << [some_key, some_value]
      resize! if @hash_map[lookup_value].count > 5
      return some_value
    end

    def [](some_key)
      lookup_value = hash_something(some_key)
      return nil if @hash_map[lookup_value].nil?
      key_value_pair = @hash_map[lookup_value].select { |kvp| kvp[0] == some_key }
      if key_value_pair.count != 1
        raise 'bad collission'
      end
      return key_value_pair[0][1]
    end

    def hash_something(some_object)
      return some_object.hash % @mod_reducer
    end

    def resize!
      @mod_reducer *= MOD_MULTIPLIER
      old_hash_map = @hash_map
      @hash_map = []
      old_hash_map.each do |key_value_pairs|
        next if key_value_pairs.nil?
        key_value_pairs.each do |key_value_pair|
          key = key_value_pair[0]
          value = key_value_pair[1]
          self[key] = value
        end
      end
    end

  end
end

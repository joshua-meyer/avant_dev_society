require_relative './base_hash_structure.rb'

module JoshsHashStructures
  class EncodingBased < Base

    def hash_something(some_object)
      hexed_string = some_object.to_s.unpack("H*")[0]
      array_of_hexed_letters = hexed_string.split("").each_slice(2).to_a.map{ |letter| letter.join("") }
      array_of_base_10_letters = array_of_hexed_letters.map{ |letter| letter.to_i(10) }
      raw_value = array_of_base_10_letters.inject(0) { |sum, number| sum += number }
      return raw_value % @mod_reducer
    end

  end
end

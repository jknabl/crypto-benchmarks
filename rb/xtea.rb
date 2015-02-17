$LOAD_PATH << '.'
require_relative 'cryptohelp'

class XTEA
  MASK = 0xFFFFFFFF
  MAGIC_CONSTANT = 0x9e3779b9
  ITERATIONS = 32
  # v is an array of 32-bit int representations.
  # k is an array of 32-bit int representations (max length 4, i.e. a 128-bit key)
  def self.encrypt_block(v, k, iter=ITERATIONS)
    # set up initial blocks
    y, x = v[0], v[1]
    sum = 0

    (1..iter).each do |i|
      #puts "On iteration #{i}, y is #{y} and x is #{x}"
      y += (((x << 4) ^ (x >> 5) + x) ^ (sum + k[sum & 3])) & MASK
      #y = y & 0xFFFFFFFF
      sum += MAGIC_CONSTANT
      x += (((y << 4) ^ (y >> 5) + y) ^ (sum + k[(sum>>11) & 3])) & MASK
      #x = x & 0xFFFFFFFF
    end
    # return ciphertext
    return [y, x]
  end

  def self.decrypt_block(v, k, iter=ITERATIONS)
    # set up initial blocks
    y, x = v[0], v[1]
    sum = MAGIC_CONSTANT * iter 
    #puts "In TEA, key is #{k} #{k[0].class}"
    #puts "In TEA, text is #{v}, #{v[0].class}"
    (1..iter).each do |i|
      #puts "On iteration #{i}, y is #{y} and x is #{x}"

      x -= (((y << 4) ^ (y >> 5) + y) ^ (sum + k[(sum>>11) & 3])) & MASK
      sum -= MAGIC_CONSTANT
      y -= (((x << 4) ^ (x >> 5) + x) ^ (sum + k[sum & 3])) & MASK
    end
    # return ciphertext
    return [y, x]
  end
end

# key = "blehbhelbhelbhel"
# test_string = "thisisavery large string that i am going to encrypt"

# chunked_string = Crypto.plaintext_to_4char_chunks(test_string)
# chunked_key = Crypto.plaintext_to_4char_chunks(key)
# puts "Original plaintext is: #{chunked_string[0..1].pack('V*')}"
# puts "Chunked string is #{chunked_string}, chunked key is #{chunked_key}"

# ciphertext = XTEA.encrypt_block(chunked_string, chunked_key)
# puts "Ciphertext is #{Crypto.convert_fixnum_to_string(ciphertext)}"

# plaintext = XTEA.decrypt_block(ciphertext, chunked_key)
# puts "Plaintext is #{Crypto.convert_fixnum_to_string(plaintext)}"
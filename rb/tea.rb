#!/usr/bin ruby

$LOAD_PATH << '.'
require_relative 'cryptohelp'

class TEA
	MASK = 0xFFFFFFFF
	MAGIC_CONSTANT = 0x9e3779b9
	ITERATIONS = 32
	# v is an array of 32-bit int representations.
	# k is an array of 32-bit int representations (max length 4, i.e. a 128-bit key)
	def self.encrypt_block(v, k, iter=ITERATIONS)
		# set up initial blocks
		y, x = v[0], v[1]
		sum = 0
		k0, k1, k2, k3 = k[0], k[1], k[2], k[3]
		#puts "In TEA, key is #{k} #{k[0].class}"
		#puts "In TEA, text is #{v}, #{v[0].class}"
		(1..iter).each do |i|
			y += (((x << 4) + k0) ^ (x + sum) ^ ( (x >> 5) + k1)) & MASK

			sum += MAGIC_CONSTANT
			x += (((y << 4) + k2) ^ (y + sum) ^ ((y >> 5) + k3)) & MASK
			#puts "On iteration #{i}, y is #{y} and x is #{x}"
 		end
 		# return ciphertext
 		return [y, x]
	end

	def self.decrypt_block(v, k, iter=ITERATIONS)
		y, x = v[0], v[1]
		k0, k1, k2, k3 = k[0], k[1], k[2], k[3]
		sum = MAGIC_CONSTANT * iter
		(1..ITERATIONS).each do |i|
			x -= (((y << 4) + k2) ^ (y + sum) ^ ((y >> 5) + k3)) & MASK
			sum -= MAGIC_CONSTANT
			y -= (((x << 4) + k0) ^ (x + sum) ^ ((x >> 5) + k1)) & MASK
			#puts "On iteration #{i}, y is #{y} and x is #{x}"
		end
		# return plaintext
		return [y, x]
	end
end

# key = "blehbhelbhelbhel"
# test_string = "thisisavery large string that i am going to encrypt"

# chunked_string = Crypto.plaintext_to_4char_chunks(test_string)
# chunked_key = Crypto.plaintext_to_4char_chunks(key)
# puts "Chunked string is #{chunked_string}, chunked key is #{chunked_key}"

# ciphertext = TEA.encrypt_block(chunked_string, chunked_key)
# puts "Ciphertext is #{Crypto.convert_fixnum_to_string(ciphertext)}"

# plaintext = TEA.decrypt_block(ciphertext, chunked_key)
# puts "Plaintext is #{Crypto.convert_fixnum_to_string(plaintext)}"

# puts "the string is #{test_string} with length #{test_string.length}"
# puts "#{Crypto.string_to_n_bit_blocks(test_string, 64)}"
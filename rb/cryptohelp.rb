#!/usr/bin ruby

module Crypto

	def Crypto.convert_to_32int(v)
		# pad with 0 (null) as necessary
		if !v.length == 4
			v << '0' * (4 - v.length)
		end
		v.unpack('V*')[0]
	end

	#takes array of fixnums, converts to a string
	def Crypto.convert_fixnum_to_string(v)
		#puts "Converting #{v}"
		v.pack("V*").chars.join("")
	end


	# return binary representation of 4-character string
	def Crypto.plaintext_to_4char_chunks(v)
		s = []
		#puts "Taking in #{v}"
		v.scan(/.{1,4}/).each do |a|
			unless a.nil? or a==""
				#pad block if length is insufficient
				if a.length != 4
					a << 0 * (4 - a.length)
				end
				#puts "Converting #{a} to #{convert_to_32int(a)}"
				s.push(convert_to_32int(a))
			end
		end
		#puts "Outputting #{s.compact}"
		s.compact
	end

	def Crypto.string_to_n_bit_blocks(string, n)
		n = n/8
		l = string.length
		if l % n != 0
			string << '0' * (n - (l  % n))
		end
		string
	end
end


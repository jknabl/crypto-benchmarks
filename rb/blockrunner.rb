#/usr/bin/ruby

$LOAD_PATH << '.'
require_relative 'tea'
require_relative 'xtea'

class BlockRunner
  MASK = 0xFFFFFFFF
  #block_type: a class
  def BlockRunner.encrypt_ecb(block_type, v, k)
    ciphertext = []
    chunked_string = Crypto.plaintext_to_4char_chunks(v)
    chunked_key = Crypto.plaintext_to_4char_chunks(k)
    if chunked_string.length % 2 != 0 
      chunked_string.push(Crypto.convert_to_32int("0000"))
      chunked_string.flatten!
    end
    (0..(chunked_string.length - 1)).step(2) do |a|
      ciphertext += block_type.encrypt_block([chunked_string[a], chunked_string[a+1]], 
        chunked_key)
    end
    return ciphertext
  end

  # block_type: a class
  def BlockRunner.decrypt_ecb(block_type, v, k)
    plaintext = []
    chunked_key = Crypto.plaintext_to_4char_chunks(k)
    (0..(v.length - 1)).step(2) do |a|
      plaintext += block_type.decrypt_block([v[a], v[a+1]], chunked_key)
    end
    return Crypto.convert_fixnum_to_string(plaintext)
  end

  def BlockRunner.encrypt_cbc(block_type, v, k, iv)
    ciphertext = []
    count = 0
    chunked_string = Crypto.plaintext_to_4char_chunks(v)
    chunked_key = Crypto.plaintext_to_4char_chunks(k)
    chunked_iv = Crypto.plaintext_to_4char_chunks(iv)
    # Pad the plaintext if it is too short
    if chunked_string.length % 2 != 0 
      chunked_string.push(Crypto.convert_to_32int("0000"))
      chunked_string.flatten!
    end

    (0..(chunked_string.length - 1)).step(2) do |a|
      plaintext = []
      if count == 0
        #then this is the first encryption and we don't need to XOR the block with
        #the previous ciphertext
        ciphertext += block_type.encrypt_block([((chunked_string[0] ^ chunked_iv[0]) & MASK), 
          ((chunked_string[1] ^ chunked_iv[1]) & MASK)], chunked_key)
        #puts "chunked_string[a] is #{chunked_string[a]} and chunked_string[a+1] is #{chunked_string[a+1]}"
      else
        # this is n+1th round and we need to XOR the block with the previous ciphertext block
        ciphertext += block_type.encrypt_block(
            [((chunked_string[a] ^ ciphertext[a-2]) & MASK), 
              ((chunked_string[a+1] ^ ciphertext[a-1]) & MASK)], 
              chunked_key)
      end
      count += 1
      #puts "Ciphertext on #{count} round is #{ciphertext}"
    end
    return ciphertext
  end

  def BlockRunner.decrypt_cbc(block_type, v, k, iv) 
    plaintext = []
    count = 0
    chunked_key = Crypto.plaintext_to_4char_chunks(k)
    chunked_iv = Crypto.plaintext_to_4char_chunks(iv)
    (0..(v.length - 1)).step(2) do |a|
      if count == 0
        #Then this is the first encryption, and we need to XOR 
        #the decrypted block with the IV
        decrypted = block_type.decrypt_block([v[a], v[a+1]], chunked_key)
        plaintext.push([((decrypted[0] ^ chunked_iv[0]) & MASK), ((decrypted[1] ^ chunked_iv[1]) & MASK)])
        plaintext.flatten!
      else
        # This is the n+1th round and we need to xor the decryption of this
        # ciphertext with the previous ciphertext
        decryption = block_type.decrypt_block([v[a], v[a+1]], chunked_key)
        plaintext.push([((decryption[0] ^ v[a-2]) & MASK), ((decryption[1] ^ v[a-1]) & MASK)])
        plaintext.flatten!
      end
      count += 1
    end
    return Crypto.convert_fixnum_to_string(plaintext)
  end

end
# times = {}
# # test ebc
# key = (0...16).map { (65 + rand(26)).chr}.join
# original_plaintext = (0...10).map { (65 + rand(26)).chr }.join

# go = Time.now
# encrypted_ciphertext = BlockRunner.encrypt_ecb(TEA, original_plaintext, key)
# stop = Time.now - go
# times["TEA ECB ENCRYPT"] = stop

# go = Time.now
# decrypted_ciphertext = BlockRunner.decrypt_ecb(TEA, encrypted_ciphertext, key).gsub('0', '')
# stop = Time.now - go
# times["TEA ECB DECRYPT"] = stop

# puts "\n--- Testing TEA in ECB Mode\n\n"
# puts "Plaintext is: \n#{original_plaintext}"
# puts "Ciphertext is:"
# puts "#{Crypto.convert_fixnum_to_string(encrypted_ciphertext)}"
# puts "Decrypted ciphertext: \n#{decrypted_ciphertext}"
# puts "\nPlaintext equals decrypted ciphertext? #{(original_plaintext == decrypted_ciphertext)}"

# puts "\n--- Testing XTEA in ECB mode\n\n"
# go = Time.now
# encrypted_ciphertext = BlockRunner.encrypt_ecb(XTEA, original_plaintext, key)
# stop = Time.now - go
# times["XTEA ECB ENCRYPT"] = stop

# go = Time.now 
# decrypted_ciphertext = BlockRunner.decrypt_ecb(XTEA, encrypted_ciphertext, key).gsub('0', '')
# stop = Time.now - go
# times["XTEA ECB DECRYPT"] = stop
# puts "Plaintext is: \n#{original_plaintext}"
# puts "Ciphertext is:"
# puts "#{Crypto.convert_fixnum_to_string(encrypted_ciphertext)}"
# puts "Decrypted ciphertext: \n#{decrypted_ciphertext}"
# puts "\nPlaintext equals decrypted ciphertext? #{(original_plaintext == decrypted_ciphertext)}"

# # ---test cbc
# iv = (0...8).map { (65 + rand(26)).chr}.join

# go = Time.now
# encrypted_ciphertext = BlockRunner.encrypt_cbc(TEA, original_plaintext, key, iv)
# stop = Time.now - go
# times["TEA CBC ENCRYPT"] = stop

# go = Time.now
# decrypted_ciphertext = BlockRunner.decrypt_cbc(TEA, encrypted_ciphertext, key, iv).gsub('0', '')
# stop = Time.now - go
# times["TEA CBC DECRYPT"] = stop
# puts "\n--- Testing TEA in CBC Mode\n\n"
# puts "Plaintext is: \n#{original_plaintext}"
# puts "Ciphertext is:"
# puts "#{Crypto.convert_fixnum_to_string(encrypted_ciphertext)}"
# puts "Decrypted ciphertext: \n#{decrypted_ciphertext}"
# puts "\nPlaintext equals decrypted ciphertext? #{(original_plaintext == decrypted_ciphertext)}"

# go = Time.now
# encrypted_ciphertext = BlockRunner.encrypt_cbc(XTEA, original_plaintext, key, iv)
# stop = Time.now - go
# times["XTEA CBC ENCRYPT"] = stop

# go = Time.now
# decrypted_ciphertext = BlockRunner.decrypt_cbc(XTEA, encrypted_ciphertext, key, iv).gsub('0', '')
# stop = Time.now - go
# times["XTEA CBC DECRYPT"] = stop
# puts "\n--- Testing XTEA in CBC Mode\n\n"
# puts "Plaintext is: \n#{original_plaintext}"
# puts "Ciphertext is:"
# puts "#{Crypto.convert_fixnum_to_string(encrypted_ciphertext)}"
# puts "Decrypted ciphertext: \n#{decrypted_ciphertext}"
# puts "\nPlaintext equals decrypted ciphertext? #{(original_plaintext == decrypted_ciphertext)}"

# puts "-- Execution time measurements:\n\n"
# puts times


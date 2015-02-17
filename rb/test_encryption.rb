#!/usr/bin ruby
$LOAD_PATH << '.'
require_relative 'cryptohelp'
require_relative 'tea'
require_relative 'xtea'
require_relative 'blockrunner'

# format: ruby test_encryption.rb CIPHER MODE [MESSAGE|NUM_CHARS] VERBOSE

cipher, mode, message, verbose, num_chars = "", "", false, false, false


cipher = ARGV[0]
mode = ARGV[1]
if (ARGV[2] =~ /\A\d+\z/ ? true : false) 
  num_chars = ARGV[2].to_i
else
  message = ARGV[2]
end
if ARGV[3]
  verbose = true
end




key = (0...16).map { (65 + rand(26)).chr}.join
iv = (0...8).map { (65 + rand(26)).chr}.join


if !message 
  original_plaintext = (0...num_chars).map { (65 + rand(26)).chr }.join
else 
  original_plaintext = message
end

if cipher=="TEA"
  if mode == "ECB"
    #TEA in ECB
    encrypted = BlockRunner.encrypt_ecb(TEA, original_plaintext, key)
    decrypted = BlockRunner.decrypt_ecb(TEA, encrypted, key).gsub('0', '')
    if verbose
      puts "\n--- Testing TEA in ECB Mode\n\n"
      puts "Plaintext is: \n#{original_plaintext}"
      puts "Ciphertext is:"
      puts "#{Crypto.convert_fixnum_to_string(encrypted)}"
      puts "Decrypted ciphertext: \n#{decrypted}"
    end

  else
    #tea in CBC
    encrypted = BlockRunner.encrypt_cbc(TEA, original_plaintext, key, iv)
    decrypted = BlockRunner.decrypt_cbc(TEA, encrypted, key, iv).gsub('0', '')
    if verbose
      puts "\n--- Testing TEA in CBC Mode\n\n"
      puts "Plaintext is: \n#{original_plaintext}"
      puts "Ciphertext is:"
      puts "#{Crypto.convert_fixnum_to_string(encrypted)}"
      puts "Decrypted ciphertext: \n#{decrypted}"
      puts original_plaintext.class
      puts decrypted.class
    end
  end
else
    #cipher is XTEA
    if mode == "ECB"
      #TEA in ECB
      encrypted = BlockRunner.encrypt_ecb(XTEA, original_plaintext, key)
      decrypted = BlockRunner.decrypt_ecb(XTEA, encrypted, key).gsub('0', '')
      if verbose
        puts "\n--- Testing XTEA in ECB Mode\n\n"
        puts "Plaintext is: \n#{original_plaintext}"
        puts "Ciphertext is:"
        puts "#{Crypto.convert_fixnum_to_string(encrypted)}"
        puts "Decrypted ciphertext: \n#{decrypted}"
      end
    else
    #tea in CBC
    encrypted = BlockRunner.encrypt_cbc(XTEA, original_plaintext, key, iv)
    decrypted = BlockRunner.decrypt_cbc(XTEA, encrypted, key, iv).gsub('0', '')
    if verbose
      puts "\n--- Testing XTEA in CBC Mode\n\n"
      puts "Plaintext is: \n#{original_plaintext}"
      puts "Ciphertext is:"
      puts "#{Crypto.convert_fixnum_to_string(encrypted)}"
      puts "Decrypted ciphertext: \n#{decrypted}"
      puts original_plaintext.class
      puts decrypted.class
    end
  end

end




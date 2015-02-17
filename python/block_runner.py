import crypto_help
import tea
import xtea

class BlockRunner(object):

  def __init__(self):
    self.MASK = 0xFFFFFFFF

  def encrypt_ecb(self, block_type, k, v):
    ciphertext = []
    chunked_string = crypto_help.string_to_int_array(v)
    chunked_key = crypto_help.string_to_int_array(k)
    if len(chunked_string) % 2 != 0:
      chunked_string += crypto_help.string_to_int("0000")

    for i in xrange(0, len(chunked_string), 2):
      ciphertext += block_type.encrypt_block(chunked_key, [chunked_string[i], chunked_string[i+1]])
    return crypto_help.int_array_to_string(ciphertext)

  def decrypt_ecb(self, block_type, k, v):
    plaintext = []
    chunked_string = crypto_help.string_to_int_array(v)
    chunked_key = crypto_help.string_to_int_array(k)
    for i in xrange(0, len(chunked_string), 2):
      plaintext += block_type.decrypt_block(chunked_key, [chunked_string[i], chunked_string[i+1]])
    return crypto_help.int_array_to_string(plaintext).replace("0", "")

  def encrypt_cbc(self, block_type, k, v, iv):
    ciphertext = []
    count = 0
    chunked_string = crypto_help.string_to_int_array(v)
    chunked_key = crypto_help.string_to_int_array(k)
    chunked_iv = crypto_help.string_to_int_array(iv)
    # Pad the plaintext if it is too short
    if len(chunked_string) % 2 != 0:
      chunked_string += crypto_help.string_to_int("0000")
 
    for i in xrange(0, len(chunked_string), 2):
      plaintext = []
      if count == 0:
        #then this is the first encryption and we don't need to XOR the block with
        #the previous ciphertext
        ciphertext += block_type.encrypt_block(chunked_key, [((chunked_string[0] ^ chunked_iv[0]) & self.MASK), 
          ((chunked_string[1] ^ chunked_iv[1]) & self.MASK)])
      else:
        # this is n+1th round and we need to XOR the block with the previous ciphertext block
        ciphertext += block_type.encrypt_block(chunked_key, [((chunked_string[i] ^ ciphertext[i-2]) & self.MASK), 
              ((chunked_string[i+1] ^ ciphertext[i-1]) & self.MASK)])
      count += 1
    return crypto_help.int_array_to_string(ciphertext)

  def decrypt_cbc(self, block_type, k, v, iv):
    plaintext = []
    count = 0
    chunked_key = crypto_help.string_to_int_array(k)
    chunked_iv = crypto_help.string_to_int_array(iv)
    chunked_string = crypto_help.string_to_int_array(v)
    for i in xrange(0, len(chunked_string)-1, 2):
      if count == 0:
        #Then this is the first encryption, and we need to XOR 
        #the decrypted block with the IV
        decrypted = block_type.decrypt_block(chunked_key, [chunked_string[i], chunked_string[i+1]])
        plaintext += [(decrypted[0] ^ chunked_iv[0]) & self.MASK]
        plaintext += [(decrypted[1] ^ chunked_iv[1]) & self.MASK]
      else:
        # This is the n+1th round and we need to xor the decryption of this
        # ciphertext with the previous ciphertext
        decryption = block_type.decrypt_block(chunked_key, [chunked_string[i], chunked_string[i+1]])
        plaintext += [(decryption[0] ^ chunked_string[i-2]) & self.MASK]
        plaintext += [(decryption[1] ^ chunked_string[i-1]) & self.MASK]
      count += 1
    return crypto_help.int_array_to_string(plaintext).replace("0", "")

def main():
  t = tea.TEA()
  xt = xtea.XTEA()
  br = BlockRunner()
  plaintext = crypto_help.gen_random_n_char_string(100)
  chunked_plaintext = crypto_help.string_to_int_array(plaintext)
  key = crypto_help.gen_random_n_char_string(16)
  chunked_key = crypto_help.string_to_int_array(key)
  iv = crypto_help.gen_random_n_char_string(8)
  chunked_key = crypto_help.string_to_int_array(iv)

  print "The generated plaintext was %s" % plaintext
  print "Plaintext is %s" % chunked_plaintext
  print "--- Testing ECB mode:\n\n"
  encrypted = br.encrypt_ecb(t, key, plaintext)
  print "Encryption is %s" % encrypted
  decrypted_ciphertext = br.decrypt_ecb(t, key, encrypted)
  print "Decryption is %s" % decrypted_ciphertext
  print "Original plaintext == decrypted ciphertext?   :  %s" % (plaintext == decrypted_ciphertext) 

  print "--- Testing CBC mode:\n\n"
  encrypted = br.encrypt_cbc(t, key, plaintext, iv)
  print "Encrypted CBC is: %s" % encrypted

  decrypted_ciphertext = br.decrypt_cbc(t, key, encrypted, iv)
  print "Decrypted CBC ciphertext is:   %s" % decrypted_ciphertext
  print "Original plaintext == decrypted ciphertext?  :  %s" % (plaintext == decrypted_ciphertext)

if __name__=="__main__":
  main()
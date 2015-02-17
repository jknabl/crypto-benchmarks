import crypto_help


class TEA(object):

  def __init__(self):
    self.MASK = 0xffffffff
    self.MAGIC_CONSTANT = 0x9e3779b9
    self.ITERATIONS = 32

  
  def encrypt_block(self, k, v, iter=None):
    if iter is None:
      iter = self.ITERATIONS
    y, x = v[0], v[1]
    sum = 0
    #print "In encrypt_block, k is %s" % k
    k0, k1, k2, k3 = k[0], k[1], k[2], k[3]
    for i in range(iter):
      #print "range iter is %s" % range(iter)
      y = (y + (((x << 4) + k0) ^ (x + sum) ^ ( (x >> 5) + k1))) & self.MASK

      sum = (sum + self.MAGIC_CONSTANT) & self.MASK
      x = (x + (((y << 4) + k2) ^ (y + sum) ^ ((y >> 5) + k3))) & self.MASK
    return [y, x]

  def decrypt_block(self, k, v, iter=None):
    if iter is None:
      iter = self.ITERATIONS

    y, x = v[0], v[1]
    k0, k1, k2, k3 = k[0], k[1], k[2], k[3]
    sum = (self.MAGIC_CONSTANT * iter) & self.MASK
    for i in range(iter):
      x = (x - (((y << 4) + k2) ^ (y + sum) ^ ((y >> 5) + k3))) & self.MASK
      sum = (sum - self.MAGIC_CONSTANT) & self.MASK
      y = (y - (((x << 4) + k0) ^ (x + sum) ^ ((x >> 5) + k1))) & self.MASK
    return [y, x]


def main():
  tea = TEA()


  key = crypto_help.gen_random_n_char_string(16)
  print key
  chunked_key = crypto_help.string_to_int_array(key)
  print chunked_key

  plaintext = crypto_help.gen_random_n_char_string(8)
  print "The generated plaintext was %s" % plaintext
  chunked_plaintext = crypto_help.string_to_int_array(plaintext)
  print chunked_plaintext

  print "Plaintext is %s" % chunked_plaintext
  encryption = tea.encrypt_block(chunked_key, chunked_plaintext, 32)
  print "Encryption is %s" % encryption

  decrypted_ciphertext = tea.decrypt_block(chunked_key, encryption, 32)
  print "Decryption is %s" % decrypted_ciphertext

  print crypto_help.int_array_to_string(decrypted_ciphertext)

if __name__=="__main__":
  main()
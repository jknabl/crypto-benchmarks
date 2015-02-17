import sys
import getopt
import tea
import xtea
import crypto_help
import block_runner
def main(argv):
 # c=cipher, b=block mode, m=message, n=number of random chars to generate for message 
  block_cipher, block_mode, message = "", "", ""
  num_chars = 0
  verbose = False
  try: 
    opts, args = getopt.getopt(argv, "hc:b:m:n:v", ["help", "block_cipher=", "block_mode=", "message", "num_message_chars=", "verbose"])
  except:
    print "failed"
    usage()
    sys.exit(2)

  for opt, arg in opts:
    if opt in ("-h", "--help"):
      usage()
      sys.exit(2)
    elif opt in ("-c", "--block_cipher"):
      block_cipher = arg
      if block_cipher not in ("TEA", "XTEA"):
        print "Block cipher arg -c must be TEA or XTEA"
        sys.exit(2)
    elif opt in ("-b", "--block_mode"):
      block_mode = arg
      if block_mode not in ("ECB", "CBC"):
        print "Cipher mode must be ECB or CBC"
        sys.exit(2)
    elif opt in ("-m", "--message"):
      message = arg
      if "0" in message:
        print "Your message can't contain the character 0"
        sys.exit(2)
    elif opt in ("-n", "--num_message_chars"):
      num_chars = arg
    elif opt in ("-v", "--verbose"):
      verbose = True
  if message != "" and num_chars != 0:
    print "Can't enter both a message and a number of characters for a randomly generated message."
    sys.exit(2)
  if block_cipher == "":
    print "Please enter a block cipher -c TEA or -c XTEA"
    sys.exit(2)
  if block_mode == "":
    print "Please enter a cipher mode -b CBC or -b EBC"
    sys.exit(2)

  br = block_runner.BlockRunner()
  plaintext, key, iv, cipher, mode = "", "", "", "", ""
  key = crypto_help.gen_random_n_char_string(16)
  iv = crypto_help.gen_random_n_char_string(8)
  if message=="":
    #we're randomly generating one
    plaintext = crypto_help.gen_random_n_char_string(int(num_chars))
  else: 
    plaintext = message

  if block_cipher == "TEA":
    cipher = tea.TEA()
  elif block_cipher == "XTEA":
    cipher = xtea.XTEA()

  if block_mode == "ECB":
    encrypted = br.encrypt_ecb(cipher, key, plaintext)
    decrypted = br.decrypt_ecb(cipher, key, encrypted)
    if verbose:
      print "-- Encryption via %s using %s mode:" % (block_cipher, block_mode)
      print "Plaintext is %s" % plaintext
      print "Encrypted ciphertext is %s" % encrypted
      print "Ciphertext decrypts to %s" % decrypted
      print "Decrypted ciphertext and original plaintext are equivalent?   : %s" % (plaintext == decrypted)
  if block_mode == "CBC":
    encrypted = br.encrypt_cbc(cipher, key, plaintext, iv)
    decrypted = br.decrypt_cbc(cipher, key, encrypted, iv)
    if verbose:
      print "-- Encryption via %s using %s mode:" % (block_cipher, block_mode)
      print "Plaintext is %s" % plaintext
      print "Encrypted ciphertext is %s" % encrypted
      print "Ciphertext decrypts to %s" % decrypted
      print "Decrypted ciphertext and original plaintext are equivalent?   : %s" % (plaintext == decrypted)



  return

def usage():
  print "you need help"
if __name__=='__main__':
  main(sys.argv[1:])


import struct
import random
import string

def string_to_int(string):
  the_string = struct.unpack("<i", string)
  return the_string

# Breaks a string into int representations of 4-char chunks (32-bit integers)
def string_to_int_array(string):
  length = len(string)
  remainder = 4 - (length % 4)
  if not (remainder == 0 or remainder == 4):
    string += "0"*remainder
  chunked_string = [string[i:i+4] for i in range(0, len(string), 4)]
  array_length = len(chunked_string)
  temp = []
  for i in chunked_string:
    temp += struct.unpack("!I", i)
  return temp

def int_array_to_string(int_array):
  string = ""
  for i in int_array:
    packed = struct.pack("!I", i)
    string += packed
  return string

def gen_random_n_char_string(n):
  return ''.join(random.choice(string.ascii_uppercase) for _ in range(n))


def main():

  v = string_to_int_array("fjhauoisddfo7skjdb")
  print  v
  s = int_array_to_string(v)
  print s

if __name__=="__main__":
  main()

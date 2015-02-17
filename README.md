README
---------
Structure of the Project
-----

/src 
  /python
    __init__.py
    block_runner.py
    crypto_help.py
    tea.py
    test_encryption.py
    xtea.py
  /rb
    blockrunner.rb
    cryptohelp.rb
    tea.rb
    test_encryption.rb
    xtea.rb
  benchmarks.sh
  README.txt


Development Environment
-----

All code in this suite was developed and tested in a MacOSX 10.9.5 environment.

The Python version is 2.7.

The Ruby version is 2.0.0. 

I cannot guarantee that things will work in other environments, however I’d imagine things would be pretty portable to most Linux distros.


Test Suite Shell Script
-------

You may need to change the permissions of benchmarks.sh before you run:

chmod u+x benchmarks.sh

To run, just do:

./benchmarks.sh

The results will be appended to /src/benchmarks.txt.


Python Implementation
---------------------

Usage
------

Run python test_encryption.py [args] from the src/python/ folder as specified below. 

Command line arguments
----------------------

-c CIPHER_NAME

Where CIPHER_NAME is one of TEA or XTEA.

-b CIPHER_MODE

Where CIPHER_MODE is one of ECB or CBC

-n NUM_CHARS

Specify this argument when you want to generate a random message of length NUM_CHARS. There is no limit to the message size, so go as high as you like.

NOTE: If you are using this flag, you can NOT simultaneously use the -m flag.

-m MESSAGE

Enter a message (in "quoted string format") if you'd rather encrypt/decrypt your own message than generate a random one.

NOTE: If you are using this flag, you can NOT simultaneously use the -n flag.

-v 

If you include the -v flag, verbose output will show. Basically just shows the original plaintext, the ciphertext it encrypts to, and the decrypted ciphertext. This is to verify that the processes work. 


EXAMPLES:

a) Encrypt/decrypt a 1000-character message using TEA in CBC mode. Show output:

python test_encryption.py -c TEA -b CBC -n 1000 -v

b) Encrypt/decrypt a 1000-character message using XTEA in ECB mode. Show output:

python test_encryption.py -c XTEA -b ECB -n 1000 -v

c) Encrypt/decrypt a custom message using XTEA in CBC mode, without showing output:

python test_encryption.py -c XTEA -b CBC -m "This is a custom message" 


Ruby Implementation
—————————

Usage
——

Run ruby test_encryption.rb [args] from the /src/rb/ folder as specified below.

Command line arguments
——————————————

IMPORTANT: The Ruby implementation does not yet have the relatively failsafe command-line interface that the Python implementation does. It is imperative that you follow these exact specifications when running queries, or else your queries won’t work.

FORMAT:

ruby test_encryption.rb CIPHER MODE [NUM_CHARS | CUSTOM_MESSAGE] -v

Where:

CIPHER = A block cypher tag “TEA” or “XTEA”

MODE = A cipher mode “ECB” or “CBC”

NUM_CHARS = The length (in number of characters) for the randomly-generated plaintext string.

CUSTOM_MESSAGE = If you don’t want to generate a random plaintext string, but would rather encrypt something custom, enter the string here “in quoted format”. NOTE: your custom message cannot include the character “0”.

-v = If the -v flag is present, Ruby will print the results of encryption/decryption to the console. 

EXAMPLES:

a) Generate a 100,000 character message, encrypt it using TEA in ECB mode, and show output. 

ruby test_encryption.rb TEA ECB 100000 -v

b) Generate a 1,000,000 character message, encrypt it using XTEA in CBC mode, and do not show output.

ruby test_encryption.rb XTEA CBC 1000000

c) Provide a custom message, encrypt it using XTEA in ECB mode, and show output.

ruby test_encryption.rb XTEA ECB “This is a custom message to encrypt”



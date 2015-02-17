#/bin/bash

# test TEA in ECB mode


> benchmarks.txt

echo "Python: Running TEA ECB tests..."

echo -e "--Python:\n" >> benchmarks.txt
echo -e "--TEA, ECB, 10 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b ECB -n 10) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 100 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b ECB -n 100) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 1000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b ECB -n 1000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 10000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b ECB -n 10000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 100000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b ECB -n 100000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 500000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b ECB -n 500000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 1000000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b ECB -n 1000000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 5000000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b ECB -n 5000000) >> benchmarks.txt 2>&1 ; }


echo -e "--Ruby:\n" >> benchmarks.txt
echo "Ruby: Running TEA ECB tests..."

echo -e "\n--TEA, ECB, 10 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA ECB 10) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 100 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA ECB 100) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 1000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA ECB 1000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 10000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA ECB 10000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 100000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA ECB 100000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 500000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA ECB 500000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, ECB, 1000000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA ECB 1000000) >> benchmarks.txt 2>&1 ; }


echo -e "--Python:\n" >> benchmarks.txt
echo "Python: Running TEA CBC tests..."

echo -e "--TEA, CBC, 10 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b CBC -n 10) >> benchmarks.txt 2>&1 ; }

echo -e "--TEA, CBC, 100 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b CBC -n 100) >> benchmarks.txt 2>&1 ; }

echo -e "--TEA, CBC, 1000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b CBC -n 1000) >> benchmarks.txt 2>&1 ; }

echo -e "--TEA, CBC, 10000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b CBC -n 10000) >> benchmarks.txt 2>&1 ; }

echo -e "--TEA, CBC, 100000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b CBC -n 100000) >> benchmarks.txt 2>&1 ; }

echo -e "--TEA, CBC, 500000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b CBC -n 500000) >> benchmarks.txt 2>&1 ; }

echo -e "--TEA, CBC, 1000000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b CBC -n 1000000) >> benchmarks.txt 2>&1 ; }

echo -e "--TEA, CBC, 5000000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c TEA -b CBC -n 5000000) >> benchmarks.txt 2>&1 ; }


echo -e "--Ruby:\n" >> benchmarks.txt
echo "Ruby: Running TEA CBC tests..."
echo -e "\n--TEA, CBC, 10 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA CBC 10) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, CBC, 100 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA CBC 100) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, CBC, 1000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA CBC 1000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, CBC, 10000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA CBC 10000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, CBC, 100000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA CBC 100000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--TEA, CBC, 500000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb TEA CBC 500000) >> benchmarks.txt 2>&1 ; }


echo -e "--Python:\n" >> benchmarks.txt
echo "Python: Running XTEA ECB tests..."

echo -e "--XTEA, ECB, 10 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b ECB -n 10) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, ECB, 100 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b ECB -n 100) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, ECB, 1000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b ECB -n 1000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, ECB, 10000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b ECB -n 10000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, ECB, 100000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b ECB -n 100000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, ECB, 500000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b ECB -n 500000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, ECB, 1000000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b ECB -n 1000000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, ECB, 5000000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b ECB -n 5000000) >> benchmarks.txt 2>&1 ; }



echo -e "--Ruby:\n" >> benchmarks.txt
echo "Ruby: Running XTEA ECB tests..."

echo -e "\n--XTEA, ECB, 10 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA ECB 10) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, ECB, 100 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA ECB 100) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, ECB, 1000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA ECB 1000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, ECB, 10000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA ECB 10000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, ECB, 100000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA ECB 100000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, ECB, 500000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA ECB 500000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, ECB, 1000000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA ECB 1000000) >> benchmarks.txt 2>&1 ; }


echo "Python: Running XTEA CBC tests..."
echo -e "--Python:\n" >> benchmarks.txt
echo -e "--XTEA, CBC, 10 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b CBC -n 10) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, CBC, 100 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b CBC -n 100) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, CBC, 1000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b CBC -n 1000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, CBC, 10000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b CBC -n 10000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, CBC, 100000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b CBC -n 100000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, CBC, 500000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b CBC -n 500000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, CBC, 1000000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b CBC -n 1000000) >> benchmarks.txt 2>&1 ; }

echo -e "--XTEA, CBC, 5000000 character message\n" >> benchmarks.txt
{ time -p (python python/test_encryption.py -c XTEA -b CBC -n 5000000) >> benchmarks.txt 2>&1 ; }


echo "Ruby: Running XTEA CBC tests..."
echo -e "--Ruby:\n" >> benchmarks.txt

echo -e "\n--XTEA, CBC, 10 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA CBC 10) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, CBC, 100 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA CBC 100) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, CBC, 1000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA CBC 1000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, CBC, 10000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA CBC 10000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, CBC, 100000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA CBC 100000) >> benchmarks.txt 2>&1 ; }

echo -e "\n--XTEA, CBC, 500000 character message\n" >> benchmarks.txt
{ time -p (ruby rb/test_encryption.rb XTEA CBC 500000) >> benchmarks.txt 2>&1 ; }



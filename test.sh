#!/bin/bash

set -e

echo "-- Building PHP 7.2 image"
docker build -t php-7.2 7.2/

echo
echo "-- Testing server is running"
docker run --name app -d php-7.2; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 7.2'"

echo
echo "-- Clear"
docker rm -f -v app; sleep 5
docker rmi -f php-7.2


echo
echo "-- Building PHP 7.1 image"
docker build -t php-7.1 7.1/

echo
echo "-- Testing server is running"
docker run --name app -d php-7.1; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 7.1'"

echo
echo "-- Clear"
docker rm -f -v app; sleep 5
docker rmi -f php-7.1


echo
echo
echo "-- Building PHP 7.0 image"
docker build -t php-7.0 7.0/

echo
echo "-- Testing server is running"
docker run --name app -d php-7.0; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 7.0'"

echo
echo "-- Clear"
docker rm -f -v app; sleep 5
docker rmi -f php-7.0


echo
echo
echo "-- Building PHP 5.6 image"
docker build -t php-5.6 5.6/

echo
echo "-- Testing server is running"
docker run --name app -d php-5.6; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 5.6'"

echo
echo "-- Clear"
docker rm -f -v app; sleep 5
docker rmi -f php-5.6

echo
echo
echo "-- Building PHP 5.5 image"
docker build -t php-5.5 5.5/

echo
echo "-- Testing server is running"
docker run --name app -d php-5.5; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 5.5'"

echo
echo "-- Clear"
docker rm -f -v app; sleep 5
docker rmi -f php-5.5


echo
echo
echo "-- Building PHP 5.4 image"
docker build -t php-5.4 5.4/

echo
echo "-- Testing server is running"
docker run --name app -d php-5.4; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 5.4'"

echo
echo "-- Clear"
docker rm -f -v app; sleep 5
docker rmi -f php-5.4


echo
echo
echo "-- Building PHP 5.3 image"
docker build -t php-5.3 5.3/

echo
echo "-- Testing server is running"
docker run --name app -d php-5.3; sleep 5
docker exec -it app bash -c 'echo "echo 2;" | php -a | grep -wc 2'
docker exec -it app bash -c "php -v | grep -c 'PHP 5.3'"

echo
echo "-- Clear"
docker rm -f -v app; sleep 5
docker rmi -f php-5.3
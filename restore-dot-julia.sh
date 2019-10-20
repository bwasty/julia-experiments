#!/bin/bash
ARCHIVE=$1
# TODO!: delete first...
docker-compose run --rm \
    nb \
    sh -c "rm -rf /root/.julia/* && cd / && tar zxvf /code/$ARCHIVE"

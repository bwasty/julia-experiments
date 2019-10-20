#!/bin/bash

docker-compose run --rm \
    nb \
    tar cvfz /code/dot-julia-$(date '+%Y-%m-%d_%H-%M-%S').tar.gz /root/.julia

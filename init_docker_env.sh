#!/bin/bash
# Build and prepare volume data:
docker build -t julia-tmp .

# .julia folder
id=$(docker create julia-tmp)
docker cp $id:/root/.julia ./.julia
docker rm -v $id

# .bash_history
touch .container-bash-history

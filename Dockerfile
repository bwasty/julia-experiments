FROM julia:1.2.0-buster

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip
RUN pip3 install jupyterlab

RUN julia -e 'using Pkg; Pkg.add("IJulia")'

WORKDIR /code

CMD jupyter notebook --ip=0.0.0.0 --allow-root

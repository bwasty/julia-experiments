FROM julia:1.2.0-buster

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip
RUN pip3 install jupyterlab

# NOTE: multiple packages at once: Pkg.add(["a", "b"])
RUN julia -e 'using Pkg; Pkg.add("IJulia")'
# RUN julia -e 'using Pkg; Pkg.add("IJulia")'
# TODO: package-compiler?

WORKDIR /code

CMD jupyter notebook --ip=0.0.0.0 --allow-root

FROM julia:1.2.0-buster

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    nodejs \
    npm

RUN pip3 install jupyterlab jupytext sympy
RUN jupyter labextension install @jupyterlab/plotly-extension
RUN jupyter lab build
# TODO!!: obsolete?
# RUN jupyter nbextension install --py jupytext && \
#     jupyter nbextension enable --py jupytext

# TODO!!!: wrong path? (ui shows disabled...)
COPY jupyter-config/plugin.jupyterlab-settings /home/root/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension/


# TODO: precompile: remove .API. for Julia 1.3
RUN julia -e 'using Pkg; \
    Pkg.add(["IJulia", "Plots", "PlotlyJS", "SymPy"]); \
    Pkg.API.precompile()'

# TODO!: unroot
# https://askubuntu.com/questions/906230/run-sudo-command-with-non-root-user-in-docker-container
# https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container/49529946
VOLUME /root/.julia

WORKDIR /code

CMD jupyter notebook --ip=0.0.0.0 --allow-root

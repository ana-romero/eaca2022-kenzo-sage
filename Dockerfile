# Dockerfile for binder

FROM sagemath/sagemath:9.1

# Copy the contents of the repo in ${HOME}
COPY --chown=sage:sage . ${HOME}

RUN sage -pip install jupyterlab
RUN sage -pip install RISE
RUN sage -pip install nbconvert==5.4.1
ARG SSL_KEYSTORE_PASSWORD
USER root
RUN apt-get update
# RUN apt-get install -y apt-utils
# RUN apt-get install -y make
RUN apt-get install -y git 
RUN git clone https://github.com/miguelmarco/kenzo/
WORKDIR kenzo
RUN git checkout testing
RUN sage -ecl < compile.lisp
RUN mv kenzo--all-systems.fasb ${HOME}/sage/local/lib/ecl/kenzo.fas
WORKDIR ${HOME}
RUN ls -l sage/sage
COPY kenzo.py sage/src/sage/interfaces/
COPY kenzo.py sage/local/lib/python3.7/site-packages/sage/interfaces/
COPY kenzo_interfaces.py sage/src/sage/features/kenzo.py
COPY kenzo_interfaces.py sage/local/lib/python3.7/site-packages/sage/features/kenzo.py
COPY finite_topological_spaces.py sage/src/sage/homology/
COPY finite_topological_spaces.py sage/local/lib/python3.7/site-packages/sage/homology/
# WORKDIR sage
# RUN apt-get install -y make 
# RUN sage -br

WORKDIR ${HOME}
user 1001

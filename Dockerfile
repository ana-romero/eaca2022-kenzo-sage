# Dockerfile for binder

FROM sagemath/sagemath:9.0

# Copy the contents of the repo in ${HOME}
COPY --chown=sage:sage . ${HOME}

RUN sage -pip install jupyterlab
RUN sage -pip install RISE
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
RUN mv kenzo--all-systems.fasb ${HOME}/local/lib/ecl/kenzo.fas
WORKDIR ${HOME}
COPY kenzo.py src/sage/interfaces/
COPY kenzo.py local/lib/python3.7/site-packages/sage/interfaces/
# RUN ls -l sage/src/sage/interfaces/
# WORKDIR sage
# RUN apt-get install -y make 
# RUN sage -br
WORKDIR ${HOME}
user 1001

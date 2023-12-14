FROM plantuml/plantuml-server:jetty

USER root

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
    libssl-dev openssl \
    wget git \
    python3 pip
#    g++ make openssl build-essential wget \
#    pkg-config zlib1g-dev libssl-dev libffi-dev \

RUN ln -snf /usr/bin/python3 /usr/local/bin/python  && \
    ln -snf /usr/bin/pip3 /usr/bin/pip

# change user
USER jetty

#ENV PYENV_ROOT /.pyenv/pyenv
#ENV PATH=$HOME/.local/bin:$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# install pyenv
#WORKDIR /.pyenv
#RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

WORKDIR /app

# install spectific python version
#RUN pyenv install `cat ./python-version.txt` && \
#    pyenv global `cat ./python-version.txt` &&  \
#    pip install --upgrade pip

RUN pip install --upgrade pip && \
    python --version && \
    pip --version


# intall the python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN git config --global --add safe.directory /app

#ENTRYPOINT ["python", "-m", "mkdocs"]

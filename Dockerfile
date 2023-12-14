FROM plantuml/plantuml-server:jetty

USER root

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
    wget \
    python3 pip \
#    g++ make openssl build-essential wget \
#    pkg-config zlib1g-dev libssl-dev libffi-dev \
    git

RUN ln -snf /usr/bin/python3 /usr/local/bin/python  && \
    ln -snf /usr/bin/pip3 /usr/bin/pip

# change user
USER jetty

WORKDIR /app

ENV PYENV_ROOT /pyenv
ENV PATH $HOME/.local/bin:$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# install pyenv
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash && \
    pyenv install `cat ./python-version.txt` && \
    pyenv global `cat ./python-version.txt` &&  \
    pip install --upgrade pip

#RUN pip install requests && \
#    pip install --upgrade pip

RUN ["python", "--version"]
RUN ["pip", "--version"]

# install python modules for mkdocs

RUN #pip install --no-cache-dir -r requirements.txt


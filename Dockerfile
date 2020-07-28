FROM rocm/tensorflow:rocm3.5-tf1.15-dev

ENV DEBIAN_FRONTEND=noninteractive

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

RUN apt-get update && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG='en_US.UTF-8' \
    && apt-get install -y --no-install-recommends \
       apt-utils \
       vim \
       unicode-data \
       bash-completion \
       build-essential \
       curl \
       git \
       git-lfs \
       libbz2-dev \
       locales \
       python3-venv \
       unzip \
       wget \ 
       libopus0 \
       libsndfile1

ENV LANG='en_US.UTF-8'
ENV LC_ALL='en_US.UTF-8'

WORKDIR /

RUN git lfs install
RUN git clone --branch v0.8.0-alpha.8 https://github.com/mozilla/DeepSpeech

WORKDIR /DeepSpeech

RUN sed -i "s|tensorflow == 1.15.2|tensorflow == 1.15.0|g" /DeepSpeech/setup.py

RUN pip3 install --upgrade pip==20.0.2 wheel==0.34.2 setuptools==46.1.3 
RUN pip3 uninstall -y enum34
RUN pip3 install progressbar2 attrdict semver \
        sox pandas numba==0.47.0 \
        llvmlite==0.31.0 soundfile ds_ctcdecoder==0.7.4 \
        python-utils>=2.3.0 joblib colorlog \
        tqdm sqlalchemy>=1.1.0 cmaes>=0.5.0 \
        cliff beautifulsoup4 pytz>=2017.2 \
        scikit-learn>=0.19.0 cffi>=1.0 astor>=0.6.0 \
        tensorboard==1.15.0 tensorflow-estimator==1.15.1 python-editor>=0.3 \
        Mako cmd2>=0.8.3 pbr>=2.1.0 \
        stevedore>=1.20.0 soupsieve>1.2 threadpoolctl>=2.0.0 \
        pycparser colorama>=0.3.7 opuslib==2.0.0 optuna bs4 librosa alembic
RUN pip3 install -e .

FROM ubuntu:16.04

# 必要なパッケージ群をインストール
RUN apt-get update && apt-get install -y \
        vim screen \
        wget curl git \
        make build-essential python-dev \
        python-pip libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev
# 日本語対応
RUN apt-get install -y language-pack-ja-base language-pack-ja
ENV LANG=ja_JP.UTF-8
# クリーニング
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# install pyenv
RUN git clone https://github.com/yyuu/pyenv.git /usr/local/pyenv
ENV PYENV_ROOT /usr/local/pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN eval "$(pyenv init -)"

# install Python
RUN pyenv install 3.6.2

# Pyenv環境
RUN pip install --upgrade pip
RUN pip install ansible==2.0.0.2

# 必要なパッケージ群をインストール
RUN apt-get update && apt-get install -y \
        jq glances iotop ibus-mozc
# クリーニング
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# デスクトップ などを英語に戻せる
# LANG=C xdg-user-dirs-gtk-update
# Pyenv環境
RUN pip install --upgrade pip
RUN pip install ansible==2.0.0.2 requests pprint jupyter

# 試しに入れてみる
# 必要なパッケージ群をインストール
#RUN apt-get update && apt-get install -y \
        
# クリーニング
#RUN apt-get clean \
#    && rm -rf /var/lib/apt/lists/*

# install configs
# screenrc
RUN echo -e 'escape ^t^t\nbind ^g\nvbell off\nautodetach on\nbacktick 1 0 0 id -un\n hardstatus alwayslastline "%{= bw}%02c%{-}  %-w%{=u kw} %n %t %{-}%+w %=%1`@%H"\n startup_message off\n'

# EXPOSE
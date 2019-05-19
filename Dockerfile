FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージ群をインストール
RUN apt-get update && apt-get install -y \
        vim screen \
        wget curl git \
        make build-essential python-dev \
        python-pip libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev \
        language-pack-ja-base language-pack-ja \
        jq glances iotop ibus-mozc \
        libffi-dev && \
    apt-get clean \
    && rm -rf /var/lib/apt/lists/*
        
ENV LANG=ja_JP.UTF-8

# install pyenv
RUN git clone https://github.com/yyuu/pyenv.git /usr/local/pyenv
ENV PYENV_ROOT /usr/local/pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN eval "$(pyenv init -)"


# install Python
RUN pyenv install 3.7.2

# Pyenv環境 and kubespray
RUN pip install --upgrade pip
RUN pip install ansible==2.7.8 jinja2==2.10.1


# デスクトップ などを英語に戻せる
# LANG=C xdg-user-dirs-gtk-update
# Pyenv環境
#RUN pip install --upgrade pip
#RUN pip install requests pprint jupyter

# 試しに入れてみる
# 必要なパッケージ群をインストール
#RUN apt-get update && apt-get install -y \
        
# クリーニング
#RUN apt-get clean \
#    && rm -rf /var/lib/apt/lists/*


WORKDIR /root

# install configs
# screenrc
RUN echo -e 'escape ^t^t\nbind ^g\nvbell off\nautodetach on\nbacktick 1 0 0 id -un\n hardstatus alwayslastline "%{= bw}%02c%{-}  %-w%{=u kw} %n %t %{-}%+w %=%1`@%H"\n startup_message off\n' > ~/.screenrc

# EXPOSE

FROM centos:7
MAINTAINER fakiyer

RUN yum -y install \
  gcc \
  bzip2 \
  openssl-devel \
  libyaml-devel \
  libffi-devel \
  readline-devel \
  zlib-devel \
  gdbm-devel \
  ncurses-devel \

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'export PATH=/root/.rbenv/bin:$PATH' >> /root/.zshrc
RUN echo 'eval "$(rbenv init -)"' >> /root/.zshrc

ENV CONFIGURE_OPTS --disable-install-doc
RUN rbenv install 2.3.0
RUN rbenv global 2.3.0

RUN echo -e 'install: --no-document\nupdate: --no-document' >> ~/.gemrc
RUN rbenv exec gem install bundler

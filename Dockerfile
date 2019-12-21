FROM amazonlinux:2018.03

RUN yum update -y && yum install -y wget tar gzip gcc make perl

RUN cd /tmp \
    && wget https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.gz \
    && tar xvfz nasm-2.14.02.tar.gz \
    && cd nasm-2.14.02 \
    && ./configure --prefix=/usr/local/nasm/2_14_02 \
    && make \
    && make install \
    && ln -s /usr/local/nasm/2_14_02/bin/nasm /usr/local/bin/

ENV APP_HOME /usr/src/assemmbly_on_aws_lambda
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN nasm -f elf64 $APP_HOME/src/app.asm -o $APP_HOME/src/app.o
RUN ld $APP_HOME/src/app.o -o $APP_HOME/bin/app

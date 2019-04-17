# Scala, sbt, Boxfuse and FlyWayon Java 8
#
# URL: https://github.com/HappyMelly/docker-scala
#
# forked from: bad79s/scala
#              - https://github.com/William-Yeh/docker-scala
#
# Version     0.4

FROM ubuntu:xenial

MAINTAINER sery0ga <skotlov@gmail.com>

ENV SBT_VERSION       1.2.1
ENV BOXFUSE_VERSION   1.33.0.1460
ENV FLYWAYDB_VERSION  4.0.3
ENV BOXFUSE_DIR       boxfuse-commandline-$BOXFUSE_VERSION
ENV SCALA_TARBALL     http://www.scala-lang.org/files/archive/scala-2.12.8.deb
ENV SBT_TARBALL       https://piccolo.link/sbt-$SBT_VERSION.tgz
ENV BOXFUSE           https://files.boxfuse.com/com/boxfuse/client/boxfuse-commandline/$BOXFUSE_VERSION/$BOXFUSE_DIR.tar.gz
ENV FLYWAYDB          https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/$FLYWAYDB_VERSION/flyway-commandline-$FLYWAYDB_VERSION.tar.gz

RUN echo "===> Update APT " && \
    apt-get update && apt-get install -y \
    unzip git

RUN echo "===> Install https transport" && \
    apt-get install apt-transport-https

RUN echo "===> Add SBT repository"  && \
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && \
    apt-get update


RUN echo "===> Install wget " && \
    apt-get install wget

RUN echo "===> Install JAVA" && \
    apt-get install default-jre default-jdk default-jre-headless -y

RUN echo "===> install Scala"  && \
    wget -nv $SCALA_TARBALL  && \
    dpkg -i scala-*.deb

RUN echo "===> install sbt"  && \
    apt-get install sbt
#    cd /tmp && \
#    wget $SBT_TARBALL && \
#    tar xzf *.tgz && \
#    cp -f sbt/bin/* /usr/local/bin/ && \
#    chmod +x /usr/local/bin/sbt

RUN echo "====> install boxfuse" && \
    cd /usr/local/bin/ && \
    rm -rf boxfuse* && \
    wget $BOXFUSE && \
    tar xzf $BOXFUSE_DIR.tar.gz && \
    rm $BOXFUSE_DIR.tar.gz

ENV PATH /usr/local/bin/boxfuse:$PATH

RUN echo "====> install flywaydb" && \
    cd /usr/local/bin && \
    wget https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.0.3/flyway-commandline-4.0.3.tar.gz && \
    tar xzf *.tar.gz && \
    rm *.tar.gz

ENV PATH /usr/local/bin/flyway-$FLYWAYDB_VERSION:$PATH

RUN echo "===> install Scala"  && \
    DEBIAN_FRONTEND=noninteractive \
        apt-get install -y --force-yes curl

RUN echo "===> clean up..."  && \
    rm -f *.deb  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

# create an empty sbt project;
# then fetch all sbt jars from Maven repo so that your sbt will be ready to be used when you launch the image
COPY build.sbt /tmp/
RUN cd /tmp  && \
    sbt about && \
    rm -rf *

# Define default command.
CMD ["scala"]

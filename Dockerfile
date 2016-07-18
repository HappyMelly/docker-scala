# Scala and sbt on Java 8
#
# URL: https://github.com/HappyMelly/docker-scala
#
# forked from: bad79s/scala
#              - https://github.com/William-Yeh/docker-scala
#
# Version     0.1

FROM sery0ga/scala
MAINTAINER sery0ga <skotlov@gmail.com>

ENV ACTIVATOR_VERSION 1.3.8
ENV BOXFUSE_VERSION 1.20.4.1035
ENV BOXFUSE_DIR     boxfuse-commandline-$BOXFUSE_VERSION
ENV SCALA_TARBALL http://www.scala-lang.org/files/archive/scala-2.11.8.deb
ENV SBT_JAR       https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.8/sbt-launch.jar
ENV ACTIVATOR     https://downloads.typesafe.com/typesafe-activator/$ACTIVATOR_VERSION/typesafe-activator-$ACTIVATOR_VERSION-minimal.zip
ENV BOXFUSE       https://files.boxfuse.com/com/boxfuse/client/boxfuse-commandline/$BOXFUSE_VERSION/$BOXFUSE_DIR.tar.gz
    
RUN echo "===> Update APT " && \
    apt-get update && apt-get install -y \
    unzip 

RUN echo "===> install from Typesafe repo (contains old versions but they have all dependencies we need later on)"  && \
    DEBIAN_FRONTEND=noninteractive \
        apt-get install -y --force-yes wget  && \
    wget http://apt.typesafe.com/repo-deb-build-0002.deb  && \
    dpkg -i repo-deb-build-0002.deb  && \
    apt-get update

RUN echo "===> install Scala"  && \
    DEBIAN_FRONTEND=noninteractive \
        apt-get install -y --force-yes libjansi-java  && \
    wget -nv $SCALA_TARBALL  && \
    dpkg -i scala-*.deb

RUN echo "===> get activator" && \
    cd /tmp && \
    wget $ACTIVATOR && \
    unzip *.zip && \
    rm *.zip && \ 
    cd /

ENV PATH /tmp/activator-$ACTIVATOR_VERSION-minimal/bin/:$PATH

RUN echo "====> install activator" && \
    cd /tmp && \
    activator new dummy play-scala && \
    rm -rf dummy


RUN echo "====> install boxfuse" && \
    cd /tmp/ && \
    wget $BOXFUSE && \
    tar xzf $BOXFUSE_DIR.tar.gz && \
    rm $BOXFUSE_DIR.tar.gz

ENV PATH /tmp/boxfuse:$PATH

RUN echo "===> install sbt"  && \
    wget -nv -P /usr/local/bin/  $SBT_JAR    && \
    \
    \
    \
    echo "===> install Scala"  && \
    DEBIAN_FRONTEND=noninteractive \
        apt-get install -y --force-yes curl  && \
    \
    \
    \    
    echo "===> clean up..."  && \
    rm -f *.deb  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*


COPY sbt /usr/local/bin/


# create an empty sbt project;
# then fetch all sbt jars from Maven repo so that your sbt will be ready to be used when you launch the image
COPY test-sbt.sh /tmp/
RUN cd /tmp  && \
    ./test-sbt.sh  && \
    rm -rf *

# print versions
#RUN java -version

# scala -version returns code 1 instead of 0 thus "|| true"
#RUN scala -version || true



# Define default command.
CMD ["scala"]

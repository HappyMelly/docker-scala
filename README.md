Docker-Scala
============

## Summary

Repository name in Docker Hub: **[williamyeh/scala](https://registry.hub.docker.com/u/bad79s/scala/)**

This repository contains Dockerized [Java](https://www.java.com/) and [Scala](http://www.scala-lang.org), published to the public [Docker Hub](https://registry.hub.docker.com/) via **automated build** mechanism.



## Configuration

This docker image contains the following software stack:

- OS: Debian jessie.

- Java: Oracle JDK 1.8.x

- Scala: 2.11.4, 2.11.2, 2.10.4 (see [tag list](https://registry.hub.docker.com/u/williamyeh/scala/tags/manage/) for details)

- Sbt: 0.13.6



### Dependencies

* [williamyeh/java8](https://github.com/William-Yeh/docker-java8)




## Installation


Latest version:

   ```
   $ docker pull bad79s/scala:latest
   ```

All versions:

   ```
   $ docker pull bad79s/scala
   ```

Specific version:

   ```
   $ docker pull bad79s/scala:2.11.4
   ```



## Usage

Used mostly as a base image for other Scala-based applications. But if you'd like to use the CLI, here are some examples for you.


#### Run `scala` REPL

```
$ docker run -it --rm bad79s/scala
```

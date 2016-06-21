Docker-Scala
============

## Summary

Repository name in Docker Hub: **[sery0ga/scala](https://registry.hub.docker.com/u/sery0ga/scala/)**

This repository contains Dockerized [Java](https://www.java.com/) and [Scala](http://www.scala-lang.org), published to the public [Docker Hub](https://registry.hub.docker.com/) via **automated build** mechanism.



## Configuration

This docker image contains the following software stack:

- OS: Debian jessie.

- Java: Oracle JDK 1.8.x

- Scala: 2.11.8 (see [tag list](https://registry.hub.docker.com/u/sery0ga/scala/tags/manage/) for details)

- Sbt: 0.13.8



### Dependencies

* [williamyeh/java8](https://github.com/William-Yeh/docker-java8)




## Installation


Latest version:

   ```
   $ docker pull sery0ga/scala:latest
   ```

All versions:

   ```
   $ docker pull sery0ga/scala
   ```

Specific version:

   ```
   $ docker pull sery0ga/scala:2.11.7
   ```



## Usage

Used mostly as a base image for other Scala-based applications. But if you'd like to use the CLI, here are some examples for you.


#### Run `scala` REPL

```
$ docker run -it --rm sery0ga/scala
```

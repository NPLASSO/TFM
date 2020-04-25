FROM centos:7
MAINTAINER name :Ignacio Pérez Lasso de la Vega mail: ignacio.perezlasso@alumnos.upm.es

# Variables
ENV SPARK_VERSION 2.4.5
ENV HADOOP_VERSION 2.7
ENV JAVA_VERSION 1.8.0
ENV MASTER_DNS sparkmaster.ddns.net

#Install Java and set up environment variable
RUN yum install -y \
       java-1.8.0-openjdk \
       java-1.8.0-openjdk-devel

ENV JAVA_HOME /usr/lib/jvm/java-$JAVA_VERSION-openjdk/

#Change to opt directories
WORKDIR /opt

#Download, install and add spark
ADD http://apache.uvigo.es/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz ./

RUN tar xvzf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz \
    && rm spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz


#Change to spark sbin directory
WORKDIR /opt/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION/bin

#Run spark slave on master host
CMD ./spark-class org.apache.spark.deploy.worker.Worker spark://$MASTER_DNS:7077


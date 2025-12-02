FROM eclipse-temurin:17-jdk

# Install required utilities
RUN apt-get update && apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Install Tomcat 10.1
ENV CATALINA_HOME=/usr/local/tomcat
RUN mkdir -p $CATALINA_HOME
WORKDIR /tmp

RUN wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.49/bin/apache-tomcat-10.1.49.tar.gz && \
    tar -xvf apache-tomcat-10.1.49.tar.gz && \
    cp -R apache-tomcat-10.1.49/* $CATALINA_HOME && \
    rm -rf apache-tomcat-10.1.49*

# Deploy WAR file
COPY **/*.war $CATALINA_HOME/webapps/

EXPOSE 8080

CMD ["bash", "-c", "$CATALINA_HOME/bin/catalina.sh run"]

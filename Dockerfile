FROM eclipse-temurin:25-jre AS java
 
FROM ubuntu
 
COPY --from=java /opt/java/openjdk /opt/java/openjdk
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
 
RUN apt-get update && \
    apt-get install -y curl wget screen && \
    rm -rf /var/lib/apt/lists/*
 
WORKDIR /data
 
RUN wget https://piston-data.mojang.com/v1/objects/33680f5f2ac32864d6d7cf5e56a705fdb3e05f4c/server.jar && \
    echo eula=true > eula.txt
 
COPY server.properties /data
 
EXPOSE 25565
 
CMD ["java", "-Xms1G", "-Xmx4G", "-jar", "server.jar", "nogui"]
 

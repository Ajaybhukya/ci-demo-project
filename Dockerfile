FROM jenkins/jenkins:lts

USER root

# Install Maven only (Java already exists)
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean

# Verify installations
RUN java -version && mvn -version

USER jenkins
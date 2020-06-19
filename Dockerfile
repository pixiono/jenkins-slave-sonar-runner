FROM openjdk:jre-alpine
LABEL maintainer="CN Services <noninojulian@gmail.com>"

RUN apk add --no-cache git subversion mercurial wget curl unzip openssh ca-certificates procps bash && \
    rm -rf /var/cache/apk/*

# Install Sonar Runner
ENV SONAR_SCANNER_VERSION 4.3.0.2102
RUN mkdir -p /opt && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    mv sonar-scanner-${SONAR_SCANNER_VERSION}-linux /opt/sonar-scanner && \
    rm -rf sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip  && \
    rm -rf /opt/sonar-scanner/conf/sonar-scanner.properties

ENV SONAR_SCANNER_HOME /opt/sonar-scanner
ENV PATH $SONAR_SCANNER_HOME/bin:$PATH

RUN addgroup -S -g 10000 jenkins && \
    adduser -S -u 10000 -h /home/jenkins -G jenkins jenkins

USER jenkins
WORKDIR /home/jenkins

CMD ["/bin/sh"]

FROM openjdk:jre-alpine
LABEL maintainer="Julian Nonino <noninojulian@outlook.com>"

RUN apk add --no-cache git openssh subversion mercurial wget curl unzip && \
    rm -rf /var/cache/apk/*

# Install Sonar Runner
ENV SONAR_RUNNER_VERSION 2.4
RUN mkdir -p /opt && \
    wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/${SONAR_RUNNER_VERSION}/sonar-runner-dist-${SONAR_RUNNER_VERSION}.zip && \
    unzip sonar-runner-dist-${SONAR_RUNNER_VERSION}.zip && \
    mv sonar-runner-${SONAR_RUNNER_VERSION} /opt/sonar-runner && \
    rm -rf sonar-runner-dist-${SONAR_RUNNER_VERSION}.zip && \
    rm -rf /opt/sonar-runner/conf/sonar-runner.properties
ENV SONAR_RUNNER_HOME /opt/sonar-runner
ENV PATH $SONAR_RUNNER_HOME/bin:$PATH

RUN mkdir /ws
WORKDIR /ws

CMD ["/bin/bash"]

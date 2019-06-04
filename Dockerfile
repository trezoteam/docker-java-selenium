FROM java

RUN useradd -m java -s /bin/bash

USER java

RUN bash -c "mkdir -p ~/{libs,run}" \
    && curl -sLo ~/libs/junit.jar 'https://search.maven.org/remotecontent?filepath=junit/junit/4.13-beta-3/junit-4.13-beta-3.jar' \
    && curl -so ~/libs/hamcrest.jar 'https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest/2.1/hamcrest-2.1.jar' \
    && mkdir -p ~/libs/selenium \
    && curl -sLo ~/libs/selenium/selenium.zip 'https://bit.ly/2zm3ZzF' \
    && unzip ~/libs/selenium/selenium.zip -d ~/libs/selenium/ \
    && bash -c "ln -s ~/libs/selenium/client-combined-*[0-9].jar ~/libs/selenium/client-combined.jar"  \
    && bash -c 'for file in ~/libs/selenium/libs/* ; do ln -s $file ${file//-[0-9]*}.jar ; done'

    ENV JAVA_LIB_PATH=/home/java/libs/selenium/libs/byte-buddy.jar:/home/java/libs/selenium/libs/commons-exec.jar:/home/java/libs/selenium/libs/guava.jar:/home/java/libs/selenium/libs/okhttp.jar:/home/java/libs/selenium/libs/okio.jar:/home/java/libs/selenium/client-combined.jar:/home/java/libs/selenium/libs/*:/home/java/libs/hamcrest.jar:/home/java/libs/junit.jar:.

    WORKDIR /home/java/run
    COPY --chown=java:java entrypoint.sh /home/java/entrypoint.sh

CMD ["/home/java/entrypoint.sh"]

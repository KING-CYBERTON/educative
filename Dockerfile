FROM educative1/ff1

RUN wget --quiet -O sdk.install.sh "https://get.sdkman.io" && \
    bash -c "bash ./sdk.install.sh > /dev/null && source ~/.sdkman/bin/sdkman-init.sh && sdk install kotlin && sdk install java 11.0.2-open && sdk install gradle 7.5 && export JAVA_HOME=/root/.sdkman/candidates/java/current/ && cd /tmp/sample/android && gradle wrapper --build-cache && cd .. && flutter pub get && cd android && gradle assembleDebug --build-cache && cd .. && flutter build apk --debug" && \
    rm -f sdk.install.sh
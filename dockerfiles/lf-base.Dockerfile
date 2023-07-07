FROM ubuntu:focal

COPY .scripts .scripts
RUN bash ./.scripts/setup.bash --dependencies-only &&\
    bash -c "curl -s "https://get.sdkman.io" | bash && source /home/gitpod/.sdkman/bin/sdkman-init.sh && sdk install java 19.0.2-open < /dev/null"
# To be continued......

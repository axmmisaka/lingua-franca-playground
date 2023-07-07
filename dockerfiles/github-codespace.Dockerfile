FROM mcr.microsoft.com/devcontainers/universal:focal

RUN ls ..
RUN pwd
COPY .scripts .scripts
RUN bash ./.scripts/setup.bash --dependencies-only && \
    bash -c "curl -s "https://get.sdkman.io" | bash && . $HOME/.sdkman/bin/sdkman-init.sh && sdk install java 20.0.1-open < /dev/null"

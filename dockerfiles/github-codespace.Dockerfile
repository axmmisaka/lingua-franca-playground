FROM mcr.microsoft.com/devcontainers/universal:focal

COPY .scripts .scripts
RUN bash ./.scripts/setup.bash --dependencies-only &&\
    # GitHub Codespaces container specific Java commands
    bash -c "source /usr/local/sdkman/bin/sdkman-init.sh && sdk install java 19.0.2-open < /dev/null"

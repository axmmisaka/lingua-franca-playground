FROM gitpod/workspace-full

COPY .scripts .scripts
RUN bash ./.scripts/setup.bash --dependencies-only && \
    bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && sdk install java 20.0.1-open < /dev/null"

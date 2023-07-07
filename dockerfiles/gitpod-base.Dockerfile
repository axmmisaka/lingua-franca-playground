FROM gitpod/workspace-full

COPY ../.scripts .scripts
RUN bash ./.scripts/setup.bash --dependencies-only

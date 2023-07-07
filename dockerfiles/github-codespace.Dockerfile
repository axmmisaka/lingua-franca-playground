FROM mcr.microsoft.com/devcontainers/universal:focal

COPY .scripts .scripts
RUN bash ./.scripts/setup.bash --dependencies-only

FROM ubuntu:focal

COPY .scripts .scripts
RUN bash ./.scripts/setup.bash --dependencies-only 
# To be continued......

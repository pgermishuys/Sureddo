FROM ubuntu
RUN apt-get update -y
RUN apt-get install curl -y
RUN curl -fsSL https://deno.land/x/install/install.sh
RUN apt-get -qq remove
ENV DENO_INSTALL=/root/.deno
ENV PATH=/root/.deno/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENTRYPOINT ["deno"]

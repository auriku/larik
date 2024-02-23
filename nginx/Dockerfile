FROM nginx

LABEL maintainer="Aurimas Kuniutis"

RUN useradd --create-home --shell /bin/bash --groups www-data nginx myuser

USER myuser

CMD [ "docker-entrypoint.sh" ]
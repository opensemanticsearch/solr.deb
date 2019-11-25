FROM solr:7.7.2

USER root

RUN apt-get update && apt-get install --no-install-recommends --yes hunspell-hu

COPY ./var/solr/data /opt/solr/server/solr/
RUN chown -R solr:solr /opt/solr/server/solr/

USER solr

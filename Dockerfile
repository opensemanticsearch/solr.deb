FROM docker.io/solr

USER root

RUN apt-get update && apt-get install --no-install-recommends --yes hunspell-hu && mkdir -p /oss-data

# Copying data into a declared volume is problematic when using buildah to build containers
# or run the containers in a kubernetes cluster. In other words, the fact that it works when
# building through docker(-compose) could be seen as a coincidence. Therefor we add the data 
# to the image for later copy-ing by the 'init-var-solr' script that is provided by solr and 
# called from 'solr-foreground' (which is called directly in the CMD and inderectly from the 
# entrypoint) in https://github.com/docker-solr/docker-solr/blob/master/8.11/Dockerfile
# 
# /oss-data/opensemanticsearch has to go to /var/solr/data/opensemanticsearch
# /oss-data/opensemanticsearch-entities has to go to /var/solr/data/opensemanticsearch-entities
COPY --chown=solr:solr ./var/solr/data/opensemanticsearch /oss-data/opensemanticsearch
COPY --chown=solr:solr ./src/open-semantic-entity-search-api/src/solr/opensemanticsearch-entities /oss-data/opensemanticsearch-entities
COPY init-var-solr-oss /oss-data/
COPY etc /etc

RUN echo /oss-data/init-var-solr-oss >> /opt/docker-solr/scripts/init-var-solr

# Recreation of symbolic links for hunspell (required for windows compatibility) will be done 
# from our 'init-var-solr' extension (init-var-solr-oss) as well

USER solr

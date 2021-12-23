FROM solr

USER root

RUN apt-get update && apt-get install --no-install-recommends --yes hunspell-hu

COPY --chown=solr:solr ./var/solr/data/opensemanticsearch /var/solr/data/opensemanticsearch

COPY --chown=solr:solr ./src/open-semantic-entity-search-api/src/solr/opensemanticsearch-entities /var/solr/data/opensemanticsearch-entities

COPY etc /etc

# Recreate symbolic links for hunspell (required for windows compatibility)
RUN ln -sf /usr/share/hunspell /var/solr/data/opensemanticsearch/conf/lang/
RUN ln -sf /usr/share/hunspell /var/solr/data/opensemanticsearch-entities/conf/lang/

USER solr

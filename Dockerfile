FROM solr

USER root

RUN apt-get update && apt-get install --no-install-recommends --yes hunspell-hu

COPY --chown=solr:solr ./var/solr/data/opensemanticsearch /var/solr/data/opensemanticsearch

COPY --chown=solr:solr ./src/open-semantic-entity-search-api/src/solr/opensemanticsearch-entities /var/solr/data/opensemanticsearch-entities

# Recreate symbolic links for hunspell (required for windows compatibility)
RUN rm /opt/solr/server/solr/opensemanticsearch/conf/lang/hunspell
RUN rm /opt/solr/server/solr/opensemanticsearch-entities/conf/lang/hunspell
RUN ln -s /usr/share/hunspell /opt/solr/server/solr/opensemanticsearch/conf/lang/hunspell
RUN ln -s /usr/share/hunspell /opt/solr/server/solr/opensemanticsearch-entities/conf/lang/hunspell

USER solr

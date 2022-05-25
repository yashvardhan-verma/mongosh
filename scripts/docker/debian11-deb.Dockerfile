FROM debian:11

ARG artifact_url=""
ADD ${artifact_url} /tmp
ADD node_modules /usr/share/mongodb-csfle-library-version/node_modules
RUN apt-get update
RUN apt-get install -y man-db
RUN apt-get install -y /tmp/*mongosh_*_amd64.deb
RUN /usr/bin/mongosh --version
RUN env MONGOSH_RUN_NODE_SCRIPT=1 mongosh /usr/share/mongodb-csfle-library-version/node_modules/.bin/mongodb-csfle-library-version /usr/lib/mongosh_csfle_v1.so | grep -q ^mongo_csfle_v1-
RUN man mongosh | grep -q tlsAllowInvalidCertificates
ENTRYPOINT [ "mongosh" ]
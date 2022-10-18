FROM ubuntu:22.04

# Copy the helper scripts
COPY ./scripts /scripts
COPY ibmtpm1682.tar.gz /
COPY ./ku-mst /ku-mst

RUN /scripts/setup-full.sh

RUN echo "source /scripts/daymon.sh" >> /etc/bash.bashrc

CMD ["/scripts/demo.sh"]


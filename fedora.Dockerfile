FROM fedora:36

# Copy the helper scripts
COPY ./scripts /scripts
COPY ibmtpm1682.tar.gz /
COPY ./ku-mst /ku-mst

RUN /scripts/setup-full.sh

RUN echo "source /scripts/daymon.sh" >> /etc/bashrc

CMD ["/scripts/demo.sh"]


FROM fedora:36

COPY runner.sh /root/runner.sh
RUN dnf -y up && dnf -y install tini-static nmap-ncat procps-ng && dnf clean all

ENTRYPOINT ["/usr/bin/tini-static", "--", "/root/runner.sh"]

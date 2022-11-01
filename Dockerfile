FROM fedora:36

COPY runner.sh /root/runner.sh
RUN dnf -y up && dnf -y install dumb-init nmap-ncat && dnf clean all

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/root/runner.sh"]

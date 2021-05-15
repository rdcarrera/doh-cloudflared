FROM centos:8
ENV DOCKER_USER=user \
    #NON PRIVILEGED USER
    DNS_PORT=5553
COPY /assets /assets
RUN yum -y update \
 #https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation
 && yum -y install \
    https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.rpm \
 && chmod +x "/assets/entrypoint" \
 && adduser ${DOCKER_USER}
USER ${DOCKER_USER}
ENTRYPOINT [ "/assets/entrypoint" ]
CMD ["proxy-dns"]
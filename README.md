# Container for doh-cloudflared


## HOW-WORKS
You need access to the cloudflared server (https://1.1.1.1)
You've to nat the port within the container to access de proxy service.
```
- p 53:5553
```
If you want to use the default DNS port **53** you've to run this container as root.

## ENV

**- DOCKER_USER** &nbsp;[Default value: **user**] **:** The user within the container who execute the action.<br>
**- DNS_PORT** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Default value: **5553**] **:** The dns proxy port within the container.<br>

## PIHOLE

You need to create a network and know what is the network ip, then specify what will be the doh-cloudflared's

In this example the network will be: **dnsn**<br>
The doh-cloudflared's will be: **172.22.0.11**

You need to add 2 persistant storage to the pihole, to save configuration and dnsmasq

### docker-compose
```
version: "3"
services:
  dns:
    container_name: dohcloudflared
    image: rdcarrera/doh-cloudflared:latest
    restart: unless-stopped
    user: root
    networks:
      dnsn:
        ipv4_address: 172.22.0.11
    environment:
      DNS_PORT: 53
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    ports:
    - "53:53/tcp"
    - "53:53/udp"
    - "67:67/udp"
    - "80:80/tcp"
    environment:
      TZ: 'Europe/Madrid'
      WEBPASSWORD: 'D3f1n3S0meP4ssW0rdH3r3'
      PIHOLE_DNS: '172.22.0.11'
      DNS1: '172.22.0.11'
    volumes:
    - 'pihole-config:/etc/pihole/'
    - 'pihole-dnsmasq:/etc/dnsmasq.d/'
    dns:
    - 172.22.0.11
    cap_add:
    - NET_ADMIN
    restart: unless-stopped
    privileged: true
    networks:
      dnsn:
        ipv4_address: 172.22.0.10
networks:
  dnsn:
    driver: bridge
    ipam:
        config:
        - subnet: 172.22.0.0/24
volumes:
    pihole-config: {}
    pihole-dnsmasq: {}
```
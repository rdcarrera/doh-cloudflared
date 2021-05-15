# Container for doh-cloudflared


## HOW-WORKS
You need access to the cloudflared server (https://1.1.1.1)
You've to nat the port within the container to access de proxy service.
```
- p 53:5553
```

## ENV

**- DOCKER_USER** &nbsp;[Default value: **user**] **:** The user within the container who execute the action.<br>
**- DNS_PORT** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Default value: **5553**] **:** The dns proxy port within the container.<br>
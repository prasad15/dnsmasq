# dnsmasq
Dnsmasq docker image for popular resolvers.
Select prefered upstream DNS reslover without additional configuration.

## Docker Build
```
$ docker build -t dnsmasq .
```

## Selecting upstream DNS resolvers
While creating the container, pass the prefered upstream DNS resolver as additional argument.
Currently supported upstream DNS are :
- Google
- OpenDNS
- Cloudflare
- Quad9

### Docker RUN
```
$ docker run -dit --cap-add=NET_ADMIN --name my-resolver dnsmasq <google | opendns | cloudflare | quad9>
```

#### Example
```
$ docker run -dit --cap-add=NET_ADMIN --name my-resolver dnsmasq google
```

- `--cap-add=NET_ADMIN` : Require additional linux capibilities and make dnsmasq to listen directly on available network interface.
- `--name` : Set a name for the container, here `my-resolver` is the name of Docker container created with above example.
- `dnsmasq` : Name of the Docker image used for creating `my-resolver` container. This image name was used the above Docker build section.
- `google` : Prefered upstream DNS resolver set for dnsmasq inside `my-resolver` container.

## Update your /etc/resolv.conf
The container will listen on all available network interface.
Once the container is running, update the /etc/resolv.conf file with the IP of the base host where `my-resolver` container is running.

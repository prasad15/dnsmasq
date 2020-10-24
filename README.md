# dnsmasq
Dnsmasq docker image for popular resolvers.
Select prefered upstream DNS resolver without additional configuration.

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
$ docker run -dit -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN --name my-resolver dnsmasq <google | opendns | cloudflare | quad9>
```

#### Example
```
$ docker run -dit --cap-add=NET_ADMIN --name my-resolver dnsmasq google
```
- **-p** : Forward ports to dnsmasq container.
- **--cap-add=NET_ADMIN** : Require additional linux capibilities and make dnsmasq to listen directly on available network interface.
- **--name** : Set a name for the container, here `my-resolver` is the name of Docker container created with above example.
- **dnsmasq** : Name of the Docker image used for creating `my-resolver` container. This image name was used the above Docker build section.
- **google** : Prefered upstream DNS resolver set for dnsmasq inside `my-resolver` container.

## Update /etc/resolv.conf
The container will listen on all available network interface.
Once the container is running, update the /etc/resolv.conf file with the IP of the base host where `my-resolver` container is running (or just 127.0.0.1 if requierd only on localhost).

## Logs
Daemon and query logs are enabled. `docker logs my-resolver` command will display dnsmasq's logs.

#### Example
```
$ sudo docker run -dit -p 53:53/tcp -p 53:53/udp  --name my-resolver cloudcontainer/dnsmasq opendns
c581acc5807788f21423e565e8e6160da126d2155ea4ca8477490eea961773e6

$ dig +short @127.0.0.1 hub.docker.com  # Query on loop-back address
elb-default.us-east-1.aws.dckr.io.
us-east-1-elbdefau-1nlhaqqbnj2z8-140214243.us-east-1.elb.amazonaws.com.
3.220.14.115
52.72.152.117
52.72.182.154

$ dig +short @192.168.122.20 docker.com # Query on host's IP address
52.72.182.154
3.220.14.115
52.72.152.117

$ sudo docker logs my-resolver # Will display the logs of above dig commands
dnsmasq[6]: started, version 2.81 cachesize 150
dnsmasq[6]: compile time options: IPv6 GNU-getopt no-DBus no-UBus no-i18n no-IDN DHCP DHCPv6 no-Lua TFTP no-conntrack ipset auth no-DNSSEC loop-detect inotify dumpfile
dnsmasq[6]: reading /opt/dnsmasq/opendns-resolver
dnsmasq[6]: using nameserver 208.67.222.222#53
dnsmasq[6]: using nameserver 208.67.220.220#53
dnsmasq[6]: read /etc/hosts - 7 addresses
dnsmasq[6]: query[A] hub.docker.com from 172.17.0.1
dnsmasq[6]: forwarded hub.docker.com to 208.67.222.222
dnsmasq[6]: forwarded hub.docker.com to 208.67.220.220
dnsmasq[6]: reply hub.docker.com is <CNAME>
dnsmasq[6]: reply elb-default.us-east-1.aws.dckr.io is <CNAME>
dnsmasq[6]: reply us-east-1-elbdefau-1nlhaqqbnj2z8-140214243.us-east-1.elb.amazonaws.com is 3.220.14.115
dnsmasq[6]: reply us-east-1-elbdefau-1nlhaqqbnj2z8-140214243.us-east-1.elb.amazonaws.com is 52.72.152.117
dnsmasq[6]: reply us-east-1-elbdefau-1nlhaqqbnj2z8-140214243.us-east-1.elb.amazonaws.com is 52.72.182.154
dnsmasq[6]: query[A] docker.com from 192.168.122.20
dnsmasq[6]: forwarded docker.com to 208.67.222.222
dnsmasq[6]: forwarded docker.com to 208.67.220.220
dnsmasq[6]: reply docker.com is 52.72.182.154
dnsmasq[6]: reply docker.com is 3.220.14.115
dnsmasq[6]: reply docker.com is 52.72.152.117
```
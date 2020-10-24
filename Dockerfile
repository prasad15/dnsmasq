FROM alpine:3.12

RUN mkdir -v /opt/dnsmasq
COPY ./google-resolver /opt/dnsmasq
COPY ./opendns-resolver /opt/dnsmasq
COPY ./cloudflare-resolver /opt/dnsmasq
COPY ./quad9-resolver /opt/dnsmasq
COPY ./dns-selector.sh /opt/dnsmasq

RUN apk --no-cache add dnsmasq
EXPOSE 53 53/udp

ENTRYPOINT [ "/opt/dnsmasq/dns-selector.sh" ]
#ENTRYPOINT ["dnsmasq", "-k"]

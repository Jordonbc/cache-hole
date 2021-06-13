#!/bin/bash -e
apt-get update
apt-get install --no-install-recommends -y git jq

git clone https://github.com/Jordonbc/cache-domains.git /CacheDomains
#echo "{'ips': {'generic':	'${LANCACHE_IP}'},'cache_domains': {'default': 	'generic','blizzard': 	'generic','origin': 	'generic','riot': 	'generic','steam': 	'generic','wsus': 	'generic','xboxlive': 	'generic'}}" > /CacheDomains/scripts/config.json
cd /CacheDomains/scripts

bash create-dnsmasq.sh

ls
ls output/dnsmasq/hosts
sudo cp -rf ./output/dnsmasq/*.conf /etc/dnsmasq.d
sudo cp -rf ./output/dnsmasq/hosts/* /etc/dnsmasq/

echo "Restarting Pi-hole DNS..."
pihole restartdns

echo "Done!"
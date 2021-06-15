#!/bin/bash -ex

echo "Installing required programs"

apt-get update
apt-get install --no-install-recommends -y git jq

echo "Cloning ${CACHE_DOMAINS_REPO} to /CacheDomains"
git clone ${CACHE_DOMAINS_REPO} /CacheDomains

cd /CacheDomains/scripts

echo "Switching branch to ${CACHE_DOMAINS_BRANCH}"
git checkout ${CACHE_DOMAINS_BRANCH}
echo "Switch Complete"

#echo "{'ips': {'generic':	'${LANCACHE_IP}'},'cache_domains': {'default': 	'generic','blizzard': 	'generic','origin': 	'generic','riot': 	'generic','steam': 	'generic','wsus': 	'generic','xboxlive': 	'generic'}}" > /CacheDomains/scripts/config.json

echo "Replacing ips in config.json with ${LANCACHE_IP}"
#sed -i "s/ipaddress/${LANCACHE_IP}/g" config.json
sed -i "s/\[.*\]/[${LANCACHE_IP}]/g" config.json

echo "config.json now contains: "
cat config.json

echo "Running create-dnsmasq.sh"
bash create-dnsmasq.sh

echo "Patching Pihole with Lancache DNS entries"
sudo cp -rf ./output/dnsmasq/*.conf /etc/dnsmasq.d
sudo cp -rf ./output/dnsmasq/hosts/* /etc/dnsmasq/

echo "Patching complete!"

echo "Restarting Pi-hole DNS..."
pihole restartdns

echo "Done!"
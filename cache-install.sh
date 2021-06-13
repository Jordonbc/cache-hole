apt-get update
apt-get install --no-install-recommends -y git jq

git clone https://github.com/Jordonbc/cache-domains.git /CacheDomains
#echo "{'ips': {'generic':	'${LANCACHE_IP}'},'cache_domains': {'default': 	'generic','blizzard': 	'generic','origin': 	'generic','riot': 	'generic','steam': 	'generic','wsus': 	'generic','xboxlive': 	'generic'}}" > /CacheDomains/scripts/config.json

sh /cache-update.sh
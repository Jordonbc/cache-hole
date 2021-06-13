cd "/CacheDomains/scripts"
{
  git fetch origin
  git diff master origin/master
} &> /dev/null

# Check for changes with local master branch
if git merge-base --is-ancestor origin/master master; then
  echo "No update required."
else
  echo "Updating CDN lists..."
  {
    # Update pihole dnsmasq
    ./create-dnsmasq.sh
    sudo cp -rf ./output/dnsmasq/*.conf /etc/dnsmasq.d
    sudo cp -rf ./output/dnsmasq/hosts/* /etc/dnsmasq/
  } &> /dev/null
  # Restart pihole to update lancache domains
  echo "Restarting Pi-hole DNS..."
  pihole restartdns
fi

echo "Done!"
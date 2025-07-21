#!/bin/bash

# Passive Recon Script by ChatGPT
# Make sure required tools are installed before running this.

read -p "Enter domain name or IP: " target
output_dir="${target}_recon"
mkdir -p "$output_dir"
output_file="$output_dir/${target}_passive-recon.txt"

echo "[*] Starting passive reconnaissance on $target"
echo "[*] Output will be saved in: $output_file"

echo "======== Passive Recon Report for $target ========" > "$output_file"

### WHOIS ###
echo -e "\n[+] WHOIS Information:" >> "$output_file"
curl -s "https://who.is/whois/$target" | grep -E 'Registrar|Registrant|Name Server|Updated Date|Creation Date|Expiry Date' >> "$output_file"

### DNSRECON ###
echo -e "\n[+] DNSRecon:" >> "$output_file"
dnsrecon -d "$target" >> "$output_file" 2>/dev/null

### HARVESTER ###
echo -e "\n[+] theHarvester:" >> "$output_file"
theHarvester -d "$target" -b all >> "$output_file" 2>/dev/null

### AMASS ###
echo -e "\n[+] Amass Subdomain Enumeration:" >> "$output_file"
amass enum -d "$target" >> "$output_file" 2>/dev/null

### GAU ###
echo -e "\n[+] gau URLs:" >> "$output_file"
gau "$target" --subs | tee "$output_dir/gau_urls.txt" >> "$output_file" 2>/dev/null

### WaybackURLs ###
echo -e "\n[+] WaybackURLs:" >> "$output_file"
waybackurls "$target" | tee -a "$output_dir/waybackurls.txt" >> "$output_file" 2>/dev/null

### GF Patterns ###
echo -e "\n[+] GF Redirects:" >> "$output_file"
cat "$output_dir/waybackurls.txt" "$output_dir/gau_urls.txt" 2>/dev/null | sort -u | gf redirect | grep "=http" >> "$output_file"

echo -e "\n[+] GF SSRF:" >> "$output_file"
cat "$output_dir/waybackurls.txt" "$output_dir/gau_urls.txt" 2>/dev/null | sort -u | gf ssrf | grep "=https" >> "$output_file"

### Manual Web Recon Links ###
echo -e "\n[+] Manual Web Recon Links (Open in Browser):" >> "$output_file"
{
echo "→ Netcraft: https://sitereport.netcraft.com/?url=$target"
echo "→ Archive.org: https://web.archive.org/web/*/$target"
echo "→ CentralOps: https://centralops.net/co/DomainDossier.aspx?addr=$target"
echo "→ Shodan: https://www.shodan.io/search?query=$target"
echo "→ Censys: https://search.censys.io/domain/$target"
echo "→ BGPView: https://bgp.he.net/search?search%5Bsearch%5D=$target"
echo "→ Web-Check: https://web-check.xyz/?url=$target"
} >> "$output_file"

echo -e "\n[✔] Recon completed. Check $output_file for results."

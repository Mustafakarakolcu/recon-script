#!/bin/bash

# Hedef Domain
domain=$1

# Çıktı Dizini
output_dir="recon_output"
mkdir -p $output_dir

# Hedefin geçerli olup olmadığını kontrol et
if [ -z "$domain" ]; then
    echo "[!] Hedef domain belirtilmedi."
    exit 1
fi

echo "[+] Hedef domain: $domain"
echo "[+] Çıktılar $output_dir dizinine kaydedilecek."

# 1. Shodan Taraması
echo "[+] Shodan ile IP ve servis taraması başlatılıyor..."
shodan host $domain > $output_dir/shodan_results.txt

# 2. Censys Taraması
echo "[+] Censys ile hedef taraması başlatılıyor..."
censys search "$domain" > $output_dir/censys_results.txt

# 3. DNS Taraması
echo "[+] DNS kayıtları alınıyor..."
dnsenum $domain > $output_dir/dnsenum_results.txt

# 4. WHOIS Bilgisi
echo "[+] WHOIS bilgisi alınıyor..."
whois $domain > $output_dir/whois_results.txt

# 5. Subdomain Brute Force (Amass)
echo "[+] Subdomain brute-force başlatılıyor..."
amass enum -d $domain -o $output_dir/amass_subdomains.txt

# 6. Subdomain Brute Force (DNSmap)
echo "[+] DNS brute-force başlatılıyor..."
dnsmap $domain -w /usr/share/wordlists/dnsmap.txt -o $output_dir/dnsmap_subdomains.txt

# 7. SSL/TLS Zafiyet Taraması
echo "[+] SSL/TLS taraması başlatılıyor..."
testssl.sh $domain > $output_dir/sslscan_results.txt

# 8. Nmap Port ve Servis Tarama
echo "[+] Nmap port taraması başlatılıyor..."
nmap -p- -sV $domain -oN $output_dir/nmap_results.txt

# 9. Nikto Web Taraması
echo "[+] Nikto ile web taraması başlatılıyor..."
nikto -h $domain -o $output_dir/nikto_results.txt

# 10. OpenVAS Zafiyet Taraması
echo "[+] OpenVAS ile tam zafiyet taraması başlatılıyor..."
openvas-start

# 11. Wappalyzer Teknoloji Tespiti
echo "[+] Wappalyzer ile teknoloji tespiti yapılıyor..."
wappalyzer -u http://$domain > $output_dir/wappalyzer_results.txt

# 12. Rapor Oluşturuluyor
echo "[+] Rapor oluşturuluyor..."
pandoc $output_dir/report.txt -o $output_dir/report.pdf

echo "[+] Tarama tamamlandı. Sonuçlar $output_dir dizininde."

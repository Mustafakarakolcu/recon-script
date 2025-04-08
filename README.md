# Recon Script

Bu script, hedef bir domain hakkında bilgi toplamak için çeşitli kaynaklardan (Shodan, Censys, DNS, vb.) veri çeker. Aşağıda, script'in nasıl kurulacağı, çalıştırılacağı ve gerekli dosyaların nasıl indirileceği ile ilgili talimatları bulabilirsiniz.

## İçerik

1. [Gereksinimler](#gereksinimler)
2. [Kurulum](#kurulum)
3. [Script Kullanımı](#script-kullanımı)
4. [Çıktılar](#çıktılar)
5. [Yasal Uyarılar](#yasal-uyarılar)

---

## Gereksinimler

### Araçlar

- **Shodan**: Shodan API'yi kullanarak hedefin IP ve servis bilgilerini alacak.
- **Censys**: Hedefin sertifikalarını ve diğer ağ bilgilerini taramak için kullanılacak.
- **DNSMap**: Subdomain taraması ve brute-force yapmak için kullanılacak.
- **WHOIS**: Domainin kayıt bilgilerini çekmek için kullanılacak.

Aşağıdaki araçları sisteminize kurmanız gerekmektedir:

1. **Shodan**: 
   - Shodan API anahtarını edinmek için [Shodan](https://shodan.io) adresine gidin, bir hesap oluşturun ve API anahtarınızı alın.
   - Shodan'ı kurmak için:
     ```bash
     pip install shodan
     ```

2. **Censys**:
   - Censys API anahtarını edinmek için [Censys](https://censys.io) adresine gidin, bir hesap oluşturun ve API anahtarınızı alın.
   - Censys'i kurmak için:
     ```bash
     pip install censys
     ```

3. **DNSMap**:
   - DNSMap'ı kurmak için:
     ```bash
     sudo apt install dnsmap
     ```

4. **WHOIS**:
   - WHOIS verilerini almak için `whois` aracını kurmanız gerekebilir:
     ```bash
     sudo apt install whois
     ```

---

## Kurulum

1. **Script'in İndirilmesi**:
   - Bu repoyu GitHub üzerinden indirerek ya da `git clone` komutuyla yerel bilgisayarınıza çekebilirsiniz:
   
     ```bash
     git clone https://github.com/username/recon-script.git
     cd recon-script
     ```

2. **API Anahtarlarının Tanımlanması**:
   - `recon.sh` script'in çalışabilmesi için **Shodan** ve **Censys** API anahtarlarını belirtmeniz gerekir.
   - Bu anahtarları script’in çalıştırıldığı dizinde `.env` dosyasına veya direkt olarak `recon.sh` içinde tanımlayabilirsiniz.

     Örnek `.env` dosyası:
     ```
     SHODAN_API_KEY=your_shodan_api_key
     CENSYS_API_ID=your_censys_api_id
     CENSYS_API_SECRET=your_censys_api_secret
     ```

     veya `recon.sh` içinde:
     ```bash
     export SHODAN_API_KEY="your_shodan_api_key"
     export CENSYS_API_ID="your_censys_api_id"
     export CENSYS_API_SECRET="your_censys_api_secret"
     ```

3. **Gerekli Dosyaların İndirilmesi**:
   - Bazı dosyalar (`wordlists`, vb.) script ile birlikte gelmeyebilir. Bu dosyaların indirilmesi için aşağıdaki komutları kullanabilirsiniz:
   
     - **DNSMap wordlist**:
       ```bash
       curl -o /usr/share/wordlists/dnsmap.txt https://raw.githubusercontent.com/digination/dnsmap/master/dnsmap.txt
       ```

---

## Script Kullanımı

1. **Script'i Çalıştırma**:
   - Script'i çalıştırmak için şu komutu kullanabilirsiniz:
   
     ```bash
     ./recon.sh example.com
     ```

   - **Argument**: `example.com` yerine hedef domaini yazın.

2. **Script Aşamaları**:
   - Shodan ile IP ve servis taraması yapılır.
   - Censys ile hedef taraması başlatılır.
   - DNS kayıtları ve subdomain brute-force işlemi yapılır.
   - WHOIS bilgileri alınır.

3. **Çıktılar**:
   - Script tamamlandığında, sonuçlar `recon_output` klasöründe saklanır.
   - Bu klasörde, domainin çeşitli bilgilerini içeren dosyalar bulunur. Örnek dosya isimleri:
     - `shodan_output.json`
     - `censys_output.json`
     - `dns_output.txt`
     - `whois_output.txt`

---

## Çıktılar

Çıktılar genellikle şu formatlarda olacaktır:

- **JSON**: Shodan ve Censys gibi API'lerden alınan veriler JSON formatında kaydedilecektir.
- **Metin Dosyası**: DNS brute-force ve WHOIS gibi veriler düz metin formatında kaydedilecektir.

Bu çıktıları daha sonra analiz edebilir, raporlar oluşturabilir veya başka bir işlem için kullanabilirsiniz.

---

## Yasal Uyarılar

Bu script, yalnızca yasal ve etik hacking amacıyla kullanılmalıdır. Başkalarının sistemlerine izinsiz erişim sağlamak veya saldırılarda bulunmak yasadışıdır ve ciddi yasal sonuçlar doğurabilir. Bu script’i kullanmadan önce, hedef sistemlerin sahiplerinden izin almanız gerektiğini unutmayın.

Bu script, yalnızca eğitim ve araştırma amacıyla kullanılmalıdır. Yazılımın kullanımı tamamen sizin sorumluluğunuzdadır. Yasal olmayan aktivitelerle ilişkilendirilmekten kaçının.

**Sorumluluk Reddi**: Bu script, tamamen eğitim ve güvenlik araştırmaları amacıyla sağlanmaktadır. Herhangi bir yasal sorumluluk kabul edilmez. Kullanıcılar, script’i yalnızca yasal sınırlar içinde ve kendi sorumlulukları altında kullanmalıdır.


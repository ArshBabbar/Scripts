# Scripts
Scripts I use in my everyday pentest

//For Now only Recon Script is available i will update and add others later
//(tho i personally do a lot of work manually like got checklist and then ya..)

## ✅ Requirements

This script is designed to run on **Kali Linux** or any Debian-based system with basic recon tools. Make sure the following dependencies are installed:

---

### 🐧 **System Requirements**

* OS: Kali Linux / Debian-based distro (Ubuntu, ParrotOS, etc.)
* Shell: `bash` or `zsh`
* `go` (Golang) installed and added to your `$PATH`

---

### 🛠️ **Tools Used**

| Tool                         | Install Command                                                         | Purpose                            |
| ---------------------------- | ----------------------------------------------------------------------- | ---------------------------------- |
| `dnsrecon`                   | `sudo apt install dnsrecon`                                             | DNS record enumeration             |
| `amass`                      | `sudo apt install amass`                                                | Subdomain enumeration              |
| `theHarvester`               | `sudo apt install theharvester`                                         | Emails, subdomains, metadata       |
| `gau`                        | `go install github.com/lc/gau@latest`                                   | Collect archived URLs              |
| `waybackurls`                | `go install github.com/tomnomnom/waybackurls@latest`                    | Grab URLs from Wayback Machine     |
| `gf`                         | `go install github.com/tomnomnom/gf@latest` + pattern files (see below) | Filter URLs by vulnerability types |
| `curl`                       | Comes pre-installed                                                     | For WHOIS and web link testing     |
| `sort`, `grep`, `tee`, `cat` | Pre-installed                                                           | Text processing utilities          |

---

### 📁 **GF Pattern Setup (Required for SSRF/Redirects)**

```bash
mkdir -p ~/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns ~/.gf-patterns
cp ~/.gf-patterns/*.json ~/.gf/
```

---

### 🌐 **Internet Access**

Most tools rely on network connections to public sources like:

* `who.is`
* `archive.org`
* `sitereport.netcraft.com`
* `shodan.io`
* etc.

Make sure you're connected to the internet.

---

### ✅ Optional but Recommended

| Tool        | Command to Install                                                         | Why Use It?                |
| ----------- | -------------------------------------------------------------------------- | -------------------------- |
| `httpx`     | `go install github.com/projectdiscovery/httpx/cmd/httpx@latest`            | Check if URLs are live     |
| `subfinder` | `go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest` | Faster subdomain discovery |
| `ffuf`      | `go install github.com/ffuf/ffuf@latest`                                   | Directory/file fuzzing     |
| `nuclei`    | `go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest`       | Vulnerability scanning     |

---

### 💡 Add to `.zshrc` or `.bashrc` if using Go:

```bash
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

Then:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

---

## 🔍 To Verify Tools Are Installed:

```bash
which dnsrecon amass theHarvester waybackurls gau gf
```

//i will clean it later :) 

If they return paths, you're good to go.

---

Would you like a ready-made `README.md` with this formatted and a small usage example included?

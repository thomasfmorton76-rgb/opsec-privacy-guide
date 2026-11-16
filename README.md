high-opsec-amnesic-workflow/
├── README.md
├── docs/
│   ├── 01-hardware-firmware.md
│   ├── 02-network-isolation.md
│   ├── 03-browser-session-hygiene.md
│   └── 04-stylometry-anonymization.md
└── LICENSE
# High-OpSec Amnesic Workstation Guide

A practical, defense-in-depth operational security (OpSec) guide for maintaining strong anonymity and physical device integrity. This framework combines open-source firmware, an amnesic operating system, strict network isolation, and stylometric countermeasures.

> **Disclaimer:** Security is a process, not a single configuration. This guide addresses high-risk threat models, such as targeted surveillance and network-level adversaries. Adapt these practices to match your specific threat model.

---

## Core Architecture Overview

1. **Hardware & Firmware Layer:** Eliminating proprietary backdoors and physical tampering vectors.
2. **Operating System Layer:** Using a live, amnesic OS to leave zero forensic trace on local storage.
3. **Network Layer:** Masking Tor usage and preventing physical location correlation.
4. **Application & Behavioral Layer:** Preventing browser fingerprinting, account correlation, and linguistic identification.

---

## Repository Contents

* **[01. Hardware & Firmware Hardening](docs/01-hardware-firmware.md):** Libreboot, physical tamper checks, and hardware kill switches.
* **[02. Network & Location Isolation](docs/02-network-isolation.md):** Tails OS, Tor bridges, public Wi-Fi hygiene, and MAC address spoofing.
* **[03. Browser & Session Hygiene](docs/03-browser-session-hygiene.md):** Tor Browser security levels, window sizing, and identity compartmentalization.
* **[04. Stylometry & Text Anonymization](docs/04-stylometry-anonymization.md):** Offline round-trip translation, metadata scrubbing, and clipboard safety.

---

## Quick-Start Checklist

* [ ] Verify Libreboot firmware checksums and inspect chassis for hardware implants.
* [ ] Boot Tails OS from a read-only or verified USB drive (internal drives disconnected).
* [ ] Spoof MAC address and connect only to unassociated public Wi-Fi networks.
* [ ] Enable Tor Bridges (obfs4 or Snowflake) and disable network connection alerts.
* [ ] Set Tor Browser Security Level to **Safest** and keep the default window size.
* [ ] Draft text offline, run local round-trip translation, scrub metadata, and paste into the browser.
* [ ] Never log into personal accounts or reuse aliases across # 01. Hardware & Firmware Hardening

Software anonymity fails if the underlying hardware or firmware is compromised.

### Current Practices
* **Libreboot Firmware:** Replaces proprietary BIOS/UEFI firmware and neutralizes low-level management engines (such as Intel ME or AMD PSP) that operate independently of the main CPU.
* **Hardware Implant & Keylogger Removal:** Physical inspection of USB ports, internal headers, and keyboards to detect unauthorized hardware interceptors.

### Recommended Improvements
* **Physical Tamper-Evident Seals:** Apply serialized tamper-evident tape or custom nail polish with glitter patterns over chassis screws and ports. Photograph the pattern to detect physical access while away from the device.
* **Hardware Kill Switches:** Physically disconnect or remove internal microphones, webcams, Bluetooth modules, and internal storage drives. If your laptop lacks hardware switches, desolder or unplug the internal cables.
* **Trusted Boot Media:** Store Tails OS on a USB drive with a physical write-protect switch (e.g., Kanguru Flashblu30) to prevent persistent malware from infecting the boot medium.
* **RF Shielding:** Store the device in a tested Faraday bag when transporting it to prevent wireless wake-up signals or location # 02. Network & Location Isolation

Protecting your physical location requires separating your real-world identity from your network exit point.

### Current Practices
* **Tails OS:** Routes all traffic through the Tor network and wipes RAM upon shutdown, leaving no local disk artifacts.
* **Tor Bridges:** Conceals the fact that you are connecting to the Tor network from local ISPs or network administrators.
* **Avoiding Personal/Home Wi-Fi:** Prevents direct association between your home IP address, residential billing records, and Tor entry guard timestamps.
* **Hiding Network Connection Alerts:** Suppresses visual notifications that could alert nearby observers or shoulder-surfers to active network states.

### Recommended Improvements
* **Public Wi-Fi Operational Hygiene:**
  * Never visit the same public Wi-Fi location on a predictable schedule.
  * Avoid locations with heavy CCTV coverage, license plate readers, or mandatory SMS/captive-portal registration.
  * Leave personal mobile phones powered off in a Faraday bag or at home. Carrying a personal phone to the same Wi-Fi hotspot creates a direct physical correlation via cell tower and Wi-Fi probe logs.
* **MAC Address Spoofing:** Ensure Tails MAC address anonymization is active before connecting to any Wi-Fi access point so your network card's hardware ID cannot be logged across different locations.
* **Bridge Rotation:** Request fresh `obfs4` or `WebTunnel` bridges periodically rather than relying on a single static bridge over long periods.
* **Disable Captive Portal Unsafe Browser Risk:** If a public network requires a captive portal login, complete it quickly using Tails' Unsafe Browser, then immediately close it and restart Tor before doing any sensitive work.# 03. Browser & Session Hygiene

Even over Tor, browser behavior and session habits can uniquely fingerprint you.

### Current Practices
* **Tor Browser on "Safest" Mode:** Disables JavaScript, certain fonts, math symbols, and media formats to eliminate the largest browser attack surfaces.
* **Default Window Size:** Avoid maximizing or resizing the Tor Browser window, preventing websites from identifying your screen resolution via viewport dimensions.
* **Zero Account Logins:** Never log into personal, historical, or non-anonymous accounts during the session.

### Recommended Improvements
* **Strict Compartmentalization:** Use one Tails session per distinct persona or task. Reboot Tails completely between unrelated tasks to clear RAM, circuit states, and temporary caches.
* **No Browser Extensions:** Never install additional add-ons or extensions into Tor Browser, as they alter your browser fingerprint and break uniformity with other Tor users.
* **Onion Services First:** Whenever available, use `.onion` addresses instead of clearnet URLs to keep traffic entirely within the Tor network and avoid exit-node eavesdropping.
* **Disable WebRTC & Audio Fingerprinting:** Keep default Tails configurations intact, as they block WebRTC IP leaks and standardize canvas/audio outputs.# 04. Stylometry & Text Anonymization

Adversaries use stylometry—analyzing word choice, punctuation, sentence length, and spelling quirks—to link anonymous texts to known authors.

### Current Practices
* **Offline Drafting & Pasting:** Writing in a plain text editor offline prevents websites from capturing keystroke dynamics (typing speed, pauses, and backspace patterns) via timing attacks.
* **Local Round-Trip Translation:** Running text through an offline translation model inside Tails (e.g., English → German → English) alters syntax, idioms, and vocabulary to mask natural writing habits.

### Recommended Improvements
* **Multi-Hop Translation Pivot:** Instead of a single language pair, translate through two structurally different language families locally (e.g., English → Japanese → German → English) using offline models like Argos Translate or MarianNMT.
* **Manual Post-Processing Pass:** Automated translation can introduce distinct "translationese" artifacts. After round-trip translation, manually simplify overly formal phrasing, standardize punctuation (e.g., remove em-dashes or semicolons), and normalize regional spelling (US vs. UK English).
* **Metadata Scrubbing:** If uploading files or images instead of plain text, always run **MAT2** (Metadata Anonymisation Toolkit 2, pre-installed in Tails) to strip EXIF data, author names, timestamps, and software versions.
* **Clipboard Clearing:** Clear the system clipboard immediately after pasting sensitive text into the browser so unintended pastes do not leak data into another window.

CC0 1.0 Universal (Public Domain Dedication)

To the extent possible under law, the author has waived all copyright and related or neighboring rights to this work.

## Automated Session Setup (`scripts/opsec-session-prep.sh`)

To automate notification suppression, MAC address verification, and offline text processing inside Tails:

1. **Offline Preparation (One-Time Setup):**
   * Download `argostranslate` wheels and offline `.argosmodel` files (e.g., `en_de` and `de_en`) onto a secondary read-only USB drive.
   * Keep a copy of `scripts/opsec-session-prep.sh` on that read-only USB drive rather than unlocking Persistent Storage during sensitive sessions.
2. **Per-Session Execution:**
   * Boot Tails OS and set an **Administration Password** on the Welcome Screen.
   * Plug in your read-only tools USB, copy `opsec-session-prep.sh` to `/tmp/`, and unplug the USB drive.
   * Run the script:
     ```bash
     bash /tmp/opsec-session-prep.sh
     ```
   * Draft your message in `/tmp/draft.txt`, run the stylometry helper, and wipe your clipboard immediately after pasting.



# opsec-privacy-guide# 🛡️ High-Anonymity OpSec & Privacy Playbook

A practical, layered guide to achieving strong digital anonymity. This framework combines hardened firmware, amnesic operating systems, network obfuscation, and anti-stylometry techniques to minimize digital footprints and resist advanced tracking.

> **⚠️ Disclaimer:** Strong anonymity relies on strict operational discipline. A single slip in habit—such as logging into a personal account or leaking local metadata—can compromise an otherwise hardened technical setup.

---

## 🏗️ The 4-Layer Anonymity Stack

### Layer 1: Hardware & Firmware Integrity
* **Open-Source Firmware (Libreboot):** Replaces proprietary BIOS/UEFI firmware to eliminate low-level backdoors and remove telemetry subsystems like the Intel Management Engine (ME).
* **Physical Tamper Inspection:** Regularly inspect USB ports, keyboards, and internal motherboard headers for hardware keyloggers or unauthorized implants.
* **✨ Improvement — Peripheral & Microphone Hygiene:** Physically disconnect or disable internal microphones, webcams, and Bluetooth modules at the hardware or BIOS level.

### Layer 2: Operating System & Network Obfuscation
* **Amnesic OS (Tails):** Boots entirely into RAM from a read-only USB drive, leaving zero forensic trace on the host machine's storage once shut down.
* **Tor Bridges (obfs4 / Snowflake):** Conceals the fact that you are connecting to the Tor network from your ISP or local network administrator.
* **Network Isolation:** Never connect from home, work, or personal mobile hotspots. Use transient, unassociated public Wi-Fi networks.
* **✨ Improvement — MAC Address Spoofing & RF Awareness:** Ensure MAC address spoofing is enabled in Tails before connecting to public Wi-Fi. Keep personal smartphones powered off or in a Faraday bag while traveling to and from the connection location to prevent cell-tower location correlation.

### Layer 3: Browser & Session Discipline
* **Maximum Security Level:** Set Tor Browser's Security Level to **Safest** to disable JavaScript, certain fonts, and media types commonly used in browser exploits.
* **Anti-Fingerprinting:** Never resize or maximize the Tor Browser window. Keeping the default viewport prevents screen-resolution fingerprinting.
* **Strict Account Isolation:** Never log into personal accounts, recovery emails, or services tied to your real-world identity.
* **✨ Improvement — Compartmentalized Identities:** Use a fresh Tails boot (and a new Tor circuit) for every distinct persona or session so activities cannot be linked across time.

### Layer 4: Content & Stylometry Defense
* **Plain-Text Drafting:** Write all text in a bare-bones offline editor (like GNOME Text Editor or Vim) before pasting into the browser to prevent keystroke-dynamics tracking.
* **Offline Round-Trip Translation:** Run drafted text through a local, offline translation model inside Tails (e.g., `English → German → English`) to neutralize personal grammar quirks, idioms, and writing cadence (stylometry).
* **Suppress System Alerts:** Disable live network connection notifications and desktop pop-ups to prevent shoulder-surfing and screen-capture leaks.
* **✨ Improvement — File & Metadata Scrubbing:** Before uploading any document or image, strip all EXIF, author, and timestamp metadata using **MAT2** (built into Tails).

---

## ✅ Pre-Session OpSec Checklist

- [ ] **Environment:** Public location selected; personal phone left behind or in a Faraday bag.
- [ ] **Hardware:** Ports checked for physical implants; webcam/mic physically blocked or disabled.
- [ ] **Boot:** Tails OS booted cleanly from trusted media; MAC spoofing active.
- [ ] **Network:** Connected to public Wi-Fi using a Tor Bridge; system notifications muted.
- [ ] **Browser:** Tor Browser set to **Safest**; window size left completely untouched.
- [ ] **Content:** Text drafted offline, passed through local round-trip translation, and scrubbed of metadata.

---

## 🤝 Contributing
Security practices evolve constantly. Feel free to submit a Pull Request to refine techniques, update offline translation model recommendations, or improve threat-modeling notes.

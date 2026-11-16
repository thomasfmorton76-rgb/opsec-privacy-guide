#!/usr/bin/env bash
# ==============================================================================
# High-OpSec Amnesic Session Preparation Script (Tails OS)
# ==============================================================================
# Run this script at the start of a Tails session (with Administration Password
# enabled if installing offline packages from Persistent Storage).
# ==============================================================================

set -euo pipefail

echo "[*] Starting OpSec session hardening..."

# ------------------------------------------------------------------------------
# 1. Suppress Live Desktop & Network Connection Notifications
# ------------------------------------------------------------------------------
echo "[*] Hiding desktop and network notifications..."
gsettings set org.gnome.desktop.notifications show-banners false
gsettings set org.gnome.desktop.notifications show-in-lock-screen false
echo "[+] Desktop notification banners disabled."

# ------------------------------------------------------------------------------
# 2. Verify MAC Address Spoofing Status
# ------------------------------------------------------------------------------
echo "[*] Checking network interfaces for MAC spoofing..."
for iface in $(ls /sys/class/net/ | grep -v lo); do
    if [ -e "/sys/class/net/$iface/address" ]; then
        CURRENT_MAC=$(cat "/sys/class/net/$iface/address")
        PERM_MAC=$(ethtool -P "$iface" 2>/dev/null | awk '{print $3}' || echo "unknown")
        echo "    Interface: $iface | Current MAC: $CURRENT_MAC | Hardware MAC: $PERM_MAC"
        if [ "$CURRENT_MAC" == "$PERM_MAC" ] && [ "$PERM_MAC" != "unknown" ]; then
            echo "[!] WARNING: $iface is using its real hardware MAC address!"
        fi
    fi
done

# ------------------------------------------------------------------------------
# 3. Verify Hardware Input Devices (Check for Unexpected Keyboards/HIDs)
# ------------------------------------------------------------------------------
echo "[*] Listing connected USB & input devices (verify no unexpected HIDs):"
lsusb | awk '{print "    " $0}'

# ------------------------------------------------------------------------------
# 4. Create Local Stylometry Anonymization Helper (Offline Round-Trip)
# ------------------------------------------------------------------------------
# Assumes 'argostranslate' and language models (.argosmodel) are stored locally
# in /live/persistence/TailsData_unlocked/models/
cat << 'EOF' > /tmp/anonymize_text.py
#!/usr/bin/env python3
import sys
import subprocess

def clear_clipboard():
    subprocess.run(["xclip", "-selection", "clipboard", "-i"], input=b"", check=False)
    subprocess.run(["xclip", "-selection", "primary", "-i"], input=b"", check=False)

try:
    import argostranslate.translate
except ImportError:
    print("[!] argostranslate not installed. Load offline wheel from Persistent Storage.")
    sys.exit(1)

if len(sys.argv) < 2:
    print("Usage: python3 /tmp/anonymize_text.py <path_to_draft.txt>")
    sys.exit(1)

with open(sys.argv[1], "r", encoding="utf-8") as f:
    text = f.read().strip()

# Pivot: English -> German -> English (add 'ja' or 'ru' if models are loaded)
step1 = argostranslate.translate.translate(text, "en", "de")
step2 = argostranslate.translate.translate(step1, "de", "en")

print("\n--- ANONYMIZED OUTPUT (REVIEW & EDIT BEFORE USE) ---\n")
print(step2)
print("\n---------------------------------------------------\n")

# Copy to clipboard and wait for user to paste, then wipe clipboard
subprocess.run(["xclip", "-selection", "clipboard"], input=step2.encode("utf-8"), check=True)
print("[+] Copied to clipboard. Paste into Tor Browser now.")
input("[*] Press ENTER immediately after pasting to wipe the clipboard...")
clear_clipboard()
print("[+] Clipboard wiped.")
EOF

chmod +x /tmp/anonymize_text.py
echo "[+] Stylometry helper created at /tmp/anonymize_text.py"

# ------------------------------------------------------------------------------
# 5. Tor Browser Reminder
# ------------------------------------------------------------------------------
echo ""
echo "=============================================================================="
echo " SESSION HARDENING COMPLETE - MANUAL VERIFICATION REQUIRED:"
echo " 1. Confirm Tor Browser Security Level is set to 'Safest'."
echo " 2. Do NOT resize or maximize the Tor Browser window."
echo " 3. Draft text in /tmp/draft.txt and run: python3 /tmp/anonymize_text.py /tmp/draft.txt"
echo "=============================================================================="

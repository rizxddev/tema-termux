#!/data/data/com.termux/files/usr/bin/bash

REPO_DIR="$HOME/tema-termux"
SCRIPT_NAME="termux-premium-home"
BASHRC="$HOME/.bashrc"

repeat_char() {
  char=$1
  num=$2
  for ((i=0; i<num; i++)); do
    printf "%s" "$char"
  done
}

# Install git jika belum ada
if ! command -v git >/dev/null 2>&1; then
  pkg update && pkg install git -y
fi

# Clone repo jika belum ada
if [ ! -d "$REPO_DIR" ]; then
  git clone https://github.com/rizxddev/tema-termux.git "$REPO_DIR"
else
  echo "Repo sudah ada, melakukan update..."
  cd "$REPO_DIR"
  git pull
fi

# Copy script ke home dan beri executable
cp "$REPO_DIR/$SCRIPT_NAME" "$HOME/"
chmod +x "$HOME/$SCRIPT_NAME"

# Pasang auto run di .bashrc
sed -i '/#--- TERMUX PREMIUM HOME START/,/#--- TERMUX PREMIUM HOME END/d' "$BASHRC"
cat <<EOF >> "$BASHRC"
#--- TERMUX PREMIUM HOME START
if [ -f \$HOME/$SCRIPT_NAME ]; then
  bash \$HOME/$SCRIPT_NAME
  exit
fi
#--- TERMUX PREMIUM HOME END
EOF

echo "Instalasi selesai!"

# Tampilkan kotak pesan
BOX_WIDTH=30
echo
echo "┌$(repeat_char '─' $BOX_WIDTH)┐"
echo "│ Enter untuk menjalankan thema │"
echo "└$(repeat_char '─' $BOX_WIDTH)┘"
read -p ""

# Jalankan tema utama
bash "$HOME/$SCRIPT_NAME"

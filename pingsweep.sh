#!/bin/bash

# Fungsi cleanup saat CTRL+C
cleanup() {
    echo ""
    echo "Script dihentikan. Membersihkan proses..."
    jobs -p | xargs -r kill 2>/dev/null
    echo "Selesai."
    exit 1
}

# Tangkap sinyal CTRL+C
trap cleanup SIGINT SIGTERM

# Cek apakah argumen prefix IP diberikan
if [ "$#" -ne 1 ]; then
    echo "Penggunaan: $0 [IP Network Prefix]"
    echo "Contoh: $0 192.168.1"
    exit 1
fi

# Variabel untuk menampung prefix IP (tiga oktet pertama)
PREFIX=$1

echo "Melakukan Ping Sweep untuk jaringan $PREFIX.1 - $PREFIX.254..."
echo "Host Aktif:"

# Loop dari 1 sampai 254 (host address)
# Perintah ping dijalankan di background (&) agar lebih cepat (paralel)
for i in $(seq 1 254); do
    # -c 1: Hanya kirim 1 paket ping
    # -W 1: Timeout 1 detik (agar tidak menunggu lama)
    # &> /dev/null: Membuang semua output (agar layar tidak penuh)
    ping -c 1 -W 1 $PREFIX.$i &> /dev/null
    
    # $? adalah kode keluar (exit code) dari perintah terakhir
    # 0 berarti ping berhasil (host aktif)
    if [ $? -eq 0 ]; then
        echo "  $PREFIX.$i - UP"
    fi
done &

wait

echo ""
echo "Ping Sweep Selesai."

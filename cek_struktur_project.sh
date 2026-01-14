#!/bin/bash

# 1. Cek Struktur
echo "=========================================="
echo "      PROJECT STRUCTURE (TREE)            "
echo "=========================================="
# -I untuk mengabaikan folder tertentu
tree -I 'venv|.git|__pycache__'

echo -e "\n"

# 2. Cat file yang ada di whitelist 
echo "=========================================="
echo "      FILE CONTENTS (SOURCE CODE)         "
echo "=========================================="

FILES=(
    "main.py"
    "services/config.py"
    "services/parser.py"
    "services/whatsapp.py"
    "routers/bridge.py"
)

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "------------------------------------------"
        echo "FILE: $file"
        echo "------------------------------------------"
        cat "$file"
        echo -e "\n"
    else
        echo "File $file gak ketemu, cek dulu dah dipindah kagak."
    fi
done

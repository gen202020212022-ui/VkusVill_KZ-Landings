#!/usr/bin/env python3
"""
Простой HTTP сервер для просмотра лендингов локально
Использование: python3 view_landing.py [порт]
"""

import http.server
import socketserver
import sys
import os
from pathlib import Path

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8000

# Переходим в папку со скриптом
os.chdir(Path(__file__).parent)

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"🌐 Сервер запущен на http://localhost:{PORT}/")
    print(f"\n📱 Для доступа с iPhone:")
    print(f"   1. Убедитесь, что iPhone в той же Wi-Fi сети")
    print(f"   2. Откройте на iPhone: http://[IP_КОМПЬЮТЕРА]:{PORT}/horeca.html")
    print(f"\n💡 Чтобы узнать IP компьютера, запустите:")
    print(f"   ifconfig | grep 'inet ' | grep -v 127.0.0.1")
    print(f"\n⏹️  Нажмите Ctrl+C для остановки сервера\n")
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n\n👋 Сервер остановлен")

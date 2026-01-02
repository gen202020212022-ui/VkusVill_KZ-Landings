#!/bin/bash
# Скрипт для настройки публичного репозитория для лендингов

echo "🚀 Настройка публичного репозитория для лендингов"
echo ""

# Переходим в папку landings
cd "$(dirname "$0")"

# Проверяем, существует ли уже git репозиторий
if [ -d ".git" ]; then
    echo "⚠️  Git репозиторий уже существует в этой папке"
    read -p "Продолжить? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Инициализируем git репозиторий
echo "📦 Инициализация git репозитория..."
git init

# Создаем README если его нет
if [ ! -f "README.md" ]; then
    echo "# Лендинги для клиентов B2B" > README.md
    echo "" >> README.md
    echo "Публичные лендинги с каталогами товаров." >> README.md
    echo "" >> README.md
    echo "## Как использовать" >> README.md
    echo "" >> README.md
    echo "Лендинги генерируются автоматически через скрипт \`generate_landing.py\`" >> README.md
fi

# Добавляем файлы
git add README.md

# Первый коммит
echo "💾 Создание первого коммита..."
git commit -m "Initial commit: Public landings repository"

# Переименовываем ветку в main
git branch -M main

echo ""
echo "✅ Локальный репозиторий готов!"
echo ""
echo "📋 Следующие шаги:"
echo ""
echo "1. Создайте новый репозиторий на GitHub:"
echo "   https://github.com/new"
echo ""
echo "2. Название репозитория: VkusVill_KZ-Landings"
echo "   Visibility: ✅ Public"
echo "   НЕ инициализируйте с README!"
echo ""
echo "3. После создания репозитория выполните:"
echo "   git remote add origin https://github.com/gen202020212022-ui/VkusVill_KZ-Landings.git"
echo "   git push -u origin main"
echo ""
echo "4. Настройте GitHub Pages:"
echo "   https://github.com/gen202020212022-ui/VkusVill_KZ-Landings/settings/pages"
echo "   Source: Deploy from a branch"
echo "   Branch: main"
echo "   Folder: / (root)"
echo ""


# Настройка нового репозитория для лендингов

## Шаг 1: Создание репозитория на GitHub

1. **Откройте GitHub:**
   ```
   https://github.com/new
   ```

2. **Заполните форму:**
   - **Repository name:** `VkusVill_KZ-Landings`
   - **Description:** `Публичные лендинги для клиентов B2B`
   - **Visibility:** ✅ **Public** (важно!)
   - **Initialize repository:** ❌ НЕ ставьте галочки (репозиторий будет пустым)

3. **Нажмите "Create repository"**

4. **Скопируйте URL репозитория:**
   ```
   https://github.com/gen202020212022-ui/VkusVill_KZ-Landings.git
   ```

---

## Шаг 2: Настройка локального репозитория

Выполните команды в терминале:

```bash
cd /Users/crocodile/Desktop/Work_temp_by_Seva_Ustinov

# Создаем новую папку для публичных лендингов
mkdir -p landings-public
cd landings-public

# Инициализируем git репозиторий
git init

# Добавляем remote (замените URL на ваш)
git remote add origin https://github.com/gen202020212022-ui/VkusVill_KZ-Landings.git

# Создаем README
echo "# Лендинги для клиентов B2B" > README.md
echo "" >> README.md
echo "Публичные лендинги с каталогами товаров." >> README.md

# Первый коммит
git add README.md
git commit -m "Initial commit"

# Пушим в GitHub
git branch -M main
git push -u origin main
```

---

## Шаг 3: Настройка GitHub Pages

1. **Откройте настройки репозитория:**
   ```
   https://github.com/gen202020212022-ui/VkusVill_KZ-Landings/settings/pages
   ```

2. **Настройте Pages:**
   - **Source:** Deploy from a branch
   - **Branch:** `main`
   - **Folder:** `/ (root)`
   - **Save**

3. **Подождите 1-2 минуты**

4. **Проверьте URL:**
   ```
   https://gen202020212022-ui.github.io/VkusVill_KZ-Landings/
   ```

---

## Шаг 4: Обновление скрипта

После создания репозитория скрипт будет автоматически использовать его для загрузки лендингов.

---

## Готово! ✅

Теперь все лендинги будут загружаться в публичный репозиторий, а основной репозиторий останется приватным.

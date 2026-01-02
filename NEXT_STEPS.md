# 🚀 Следующие шаги для настройки публичного репозитория

## ✅ Что уже сделано:
- ✅ Локальный git репозиторий создан в папке `landings/`
- ✅ Скрипт `generate_landing.py` обновлен для работы с отдельным репозиторием

---

## 📋 Что нужно сделать СЕЙЧАС:

### Шаг 1: Создать репозиторий на GitHub

1. **Откройте:**
   ```
   https://github.com/new
   ```

2. **Заполните форму:**
   - **Repository name:** `VkusVill_KZ-Landings`
   - **Description:** `Публичные лендинги для клиентов B2B`
   - **Visibility:** ✅ **Public** (важно!)
   - **Initialize repository:** ❌ НЕ ставьте галочки (README, .gitignore, license)

3. **Нажмите "Create repository"**

---

### Шаг 2: Подключить локальный репозиторий к GitHub

Выполните в терминале:

```bash
cd /Users/crocodile/Desktop/Work_temp_by_Seva_Ustinov/landings

git remote add origin https://github.com/gen202020212022-ui/VkusVill_KZ-Landings.git

git push -u origin main
```

---

### Шаг 3: Настроить GitHub Pages

1. **Откройте настройки:**
   ```
   https://github.com/gen202020212022-ui/VkusVill_KZ-Landings/settings/pages
   ```

2. **Настройте:**
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

## ✅ Готово!

После выполнения этих шагов:

1. **Все новые лендинги** будут автоматически загружаться в публичный репозиторий
2. **Основной репозиторий** останется приватным ✅
3. **Ссылки будут работать** на всех устройствах (компьютер, iPhone, Android)

---

## 🎯 Формат ссылок после настройки:

```
https://gen202020212022-ui.github.io/VkusVill_KZ-Landings/[имя-файла].html
```

Например:
```
https://gen202020212022-ui.github.io/VkusVill_KZ-Landings/остатки-на-складе-b2b-на-26-декабря-2025.html
```

---

## 📝 Проверка работы:

После настройки запустите тестовый лендинг:

```bash
cd /Users/crocodile/Desktop/Work_temp_by_Seva_Ustinov/Inbox
python3 generate_landing.py "2025 12 26 Остаток на складе В2В.xlsx" "Тест"
```

Скрипт автоматически:
- ✅ Создаст HTML файл
- ✅ Загрузит в публичный репозиторий
- ✅ Покажет рабочую ссылку для всех устройств

---

## 🔒 Безопасность:

- ✅ Основной репозиторий `VkusVill_KZ-B2B` остается **приватным**
- ✅ Публичный репозиторий содержит **только HTML файлы** (без чувствительных данных)
- ✅ Лендинги безопасно публиковать (товары, цены, фото - это публичная информация)


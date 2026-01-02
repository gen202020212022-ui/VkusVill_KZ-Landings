# ⚡ БЫСТРАЯ СПРАВКА - Генератор лендингов

## 🚀 Команда для создания лендинга:

```bash
cd /Users/crocodile/Desktop/Work_temp_by_Seva_Ustinov/Inbox
python3 generate_landing.py "файл.xlsx" "Имя клиента" [короткое_имя]
```

## 🔗 Формат ссылок:

```
https://gen202020212022-ui.github.io/VkusVill_KZ-Landings/[короткое-имя]
```

## 📁 Расположение:

- **Скрипт**: `Inbox/generate_landing.py`
- **Репозиторий**: `landings/` (публичный)
- **GitHub**: `https://github.com/gen202020212022-ui/VkusVill_KZ-Landings`

## ⚙️ Что делает:

1. Читает Excel → Группирует по категориям → Генерирует HTML → Загружает на GitHub → Показывает ссылку

## 📊 Формат Excel:

- Категория (обязательно)
- Наименование / Наименование товара (обязательно)
- Ссылка на фото (обязательно)
- Количество / РРЦ / Квант (опционально)

## 🎯 Примеры:

```bash
# Автоматическое короткое имя
python3 generate_landing.py "КП.xlsx" "HoReCa"
→ Ссылка: .../horeca

# С указанием короткого имени
python3 generate_landing.py "КП.xlsx" "Остатки на складе" "ost-26dec"
→ Ссылка: .../ost-26dec
```

## ✅ Работает на всех устройствах!

Компьютер, iPhone, Android - просто скопируйте ссылку и делитесь.

---

**Полная документация:** `landings/README.md`


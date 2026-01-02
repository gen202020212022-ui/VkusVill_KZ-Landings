# 📋 Полная инструкция по созданию лендинга с корзиной и экспортом заказа

> **Назначение**: Эта инструкция содержит весь опыт создания лендинга с функциональностью корзины и экспортом заказа в файлы. Используйте её в новом чате для создания нового лендинга на основе другой Excel таблицы.

---

## 🎯 Общий обзор

### Что создается:
- **Лендинг-каталог товаров** с категориями
- **Корзина покупок** с сохранением в localStorage
- **Экспорт заказа** в CSV (Excel) и TXT файлы
- **Адаптивный дизайн** для всех устройств
- **Дизайн в стиле ВкусВилл** (зеленый #2dbe64, графитовый #333333)

### Процесс создания:
1. Чтение Excel таблицы с товарами
2. Преобразование в JSON структуру
3. Генерация HTML с встроенным JavaScript
4. Добавление функциональности корзины
5. Добавление экспорта в файлы

---

## 📊 Структура данных из Excel

### Обязательные колонки:
- **ID** или **Артикул** - уникальный идентификатор товара
- **Наименование** или **Наименование товара** - название товара
- **Категория** - категория товара (для группировки)
- **Ссылка на фото** или **сслыка на фото** - URL изображения товара

### Опциональные колонки:
- **РРЦ** или **Стоимость товара в закупке, с НДС** - цена товара (число)
- **Квант** - количество в упаковке (строка или число)
- **Вес, гр (Объём, мл)** - вес/объем товара
- **Количество** или **Остаток** - остаток на складе (для отображения)
- **Срок годности, дней** - срок годности в днях

### Пример структуры Excel:
```
| ID    | Наименование                    | Категория      | Ссылка на фото                    | РРЦ   | Квант |
|-------|----------------------------------|----------------|------------------------------------|-------|-------|
| 84334 | Молоко кокосовое, 1л             | Нон-Фуд        | https://img.vkusvill.ru/...        | 1269  | 12    |
| 65280 | Паста миндальная с шоколадом     | Бакалея        | https://img.vkusvill.ru/...        | 976   | 12    |
```

---

## 📦 Структура JSON данных для товаров

### Формат:
```javascript
const productsData = {
  "Категория 1": [
    {
      "id": "84334",
      "name": "Молоко кокосовое, 1л",
      "price": 1269.0,
      "image": "https://img.vkusvill.ru/pim/images/...",
      "quant": "12",
      "weight": "1000",
      "expiry_days": "365",
      "stock": 88  // опционально
    },
    // ... другие товары
  ],
  "Категория 2": [
    // ... товары категории 2
  ]
};
```

### Поля товара:
- **id** (string, обязательное) - уникальный ID товара
- **name** (string, обязательное) - название товара
- **price** (number, опциональное) - цена товара (0 = "Цена по запросу")
- **image** (string, обязательное) - URL изображения
- **quant** (string, опциональное) - квант (количество в упаковке)
- **weight** (string, опциональное) - вес/объем
- **expiry_days** (string, опциональное) - срок годности в днях
- **stock** (number, опциональное) - остаток на складе

---

## 🏗️ Структура HTML лендинга

### Основные секции:

1. **HEAD секция**:
   - Meta теги (charset, viewport)
   - Title (название лендинга)
   - Встроенные CSS стили
   - Адаптивный дизайн

2. **HEADER**:
   - Заголовок с названием
   - Иконка корзины с счетчиком товаров
   - Информация об общей сумме

3. **CATEGORIES VIEW** (вид категорий):
   - Список категорий с количеством товаров
   - Кнопка "Назад" (скрыта на главном экране)

4. **PRODUCTS VIEW** (вид товаров):
   - Сетка товаров с карточками
   - Каждая карточка: фото, название, цена, остаток (если есть), кнопка "В корзину"

5. **CART VIEW** (вид корзины):
   - Список товаров в корзине
   - Изменение количества (+/-)
   - Удаление товаров
   - Итоговая сумма
   - Кнопки: "Скачать заказ" и "Отправить заказ"

---

## 🛒 Функциональность корзины

### Хранение данных:
- **localStorage** браузера (сохраняется между сессиями)
- Ключ: `'cart'`
- Формат: JSON массив объектов

### Структура элемента корзины:
```javascript
{
  id: "84334",
  name: "Молоко кокосовое, 1л",
  price: 1269,
  quantity: 2,
  quant: "12"
}
```

### Ключевые функции:

#### 1. `saveCart()`
Сохраняет корзину в localStorage и обновляет счетчик:
```javascript
function saveCart() {
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartBadge();
}
```

#### 2. `updateCartBadge()`
Обновляет счетчик товаров и общую сумму в иконке корзины:
```javascript
function updateCartBadge() {
    const badge = document.getElementById('cart-badge');
    const totalInfo = document.getElementById('cart-total-info');
    const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
    const totalPrice = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    
    if (totalItems > 0) {
        badge.textContent = totalItems;
        badge.classList.remove('hidden');
        totalInfo.textContent = 'Итого: ' + formatPrice(totalPrice);
        totalInfo.classList.remove('hidden');
    } else {
        badge.classList.add('hidden');
        totalInfo.classList.add('hidden');
    }
}
```

#### 3. `addToCart(product)`
Добавляет товар в корзину или увеличивает количество:
```javascript
function addToCart(product) {
    const existingItem = cart.find(item => item.id === product.id);
    
    if (existingItem) {
        existingItem.quantity += 1;
    } else {
        cart.push({
            id: product.id,
            name: product.name,
            price: product.price || 0,
            quantity: 1,
            quant: product.quant || ''
        });
    }
    
    saveCart();
    updateProductButtons();
}
```

#### 4. `removeFromCart(productId)`
Удаляет товар из корзины:
```javascript
function removeFromCart(productId) {
    cart = cart.filter(item => item.id !== productId);
    saveCart();
    
    if (document.getElementById('cart-view').classList.contains('active')) {
        renderCart();
    }
    updateProductButtons();
}
```

#### 5. `updateQuantity(productId, newQuantity)`
Изменяет количество товара в корзине:
```javascript
function updateQuantity(productId, newQuantity) {
    const item = cart.find(item => item.id === productId);
    if (item) {
        if (newQuantity <= 0) {
            removeFromCart(productId);
        } else {
            item.quantity = newQuantity;
            saveCart();
            renderCart();
        }
    }
}
```

#### 6. `renderCart()`
Отображает корзину с товарами:
```javascript
function renderCart() {
    const cartContent = document.getElementById('cart-content');
    
    if (cart.length === 0) {
        cartContent.innerHTML = `
            <div class="empty-cart">
                <p>Корзина пуста</p>
                <p>Добавьте товары из каталога</p>
            </div>
        `;
        return;
    }
    
    let html = '';
    let total = 0;
    
    cart.forEach(item => {
        const itemTotal = item.price * item.quantity;
        total += itemTotal;
        
        const detailsParts = [];
        if (item.price > 0) {
            detailsParts.push('Цена: ' + formatPrice(item.price) + ' шт');
        }
        if (item.quant) {
            detailsParts.push('Квант: ' + item.quant);
        }
        
        html += `
            <div class="cart-item">
                <div class="cart-item-info">
                    <div class="cart-item-name">${item.name}</div>
                    <div class="cart-item-details">${detailsParts.join(' • ')}</div>
                </div>
                <div class="cart-item-controls">
                    <button onclick="updateQuantity('${item.id}', ${item.quantity - 1})">-</button>
                    <span>${item.quantity}</span>
                    <button onclick="updateQuantity('${item.id}', ${item.quantity + 1})">+</button>
                    <button class="remove-item-btn" onclick="removeFromCart('${item.id}')">Удалить</button>
                </div>
            </div>
        `;
    });
    
    html += `
        <div class="cart-total">
            <span>Итого:</span>
            <span>${total > 0 ? formatPrice(total) : '—'}</span>
        </div>
        <div class="cart-buttons-wrapper">
            <button class="download-order-btn" onclick="exportCartToFile()">📥 Скачать заказ (Excel/CSV)</button>
            <button class="submit-order-btn" onclick="submitOrder()">Отправить заказ</button>
        </div>
    `;
    
    cartContent.innerHTML = html;
}
```

---

## 📥 Экспорт заказа в файлы

### Функция `exportCartToFile()`

Экспортирует корзину в два файла: CSV (для Excel) и TXT (текстовый формат).

#### Полный код функции:
```javascript
function exportCartToFile() {
    if (cart.length === 0) {
        alert('Корзина пуста');
        return;
    }
    
    // Формируем данные заказа
    const orderDate = new Date().toLocaleString('ru-RU', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
    }).replace(/\./g, '-');
    
    const fileName = `Заказ_${clientName}_${orderDate.replace(/[:\s]/g, '_')}`;
    
    // Формируем CSV содержимое
    let csvContent = '\uFEFF'; // BOM для правильной кодировки UTF-8 в Excel
    
    // Заголовки
    csvContent += 'ID товара;Наименование;Цена за единицу;Количество;Квант;Сумма\n';
    
    // Данные товаров
    let totalSum = 0;
    cart.forEach(item => {
        const itemTotal = item.price * item.quantity;
        totalSum += itemTotal;
        
        // Экранируем кавычки и точки с запятой в названии
        const name = String(item.name || '').replace(/"/g, '""').replace(/;/g, ',');
        const price = item.price > 0 ? item.price : 'Цена по запросу';
        const quant = item.quant || '';
        
        csvContent += `${item.id};"${name}";${price};${item.quantity};${quant};${itemTotal}\n`;
    });
    
    // Итого
    csvContent += `\nИтого;;;${cart.reduce((sum, item) => sum + item.quantity, 0)};;${totalSum}\n`;
    csvContent += `\nДата заказа: ${orderDate}\n`;
    csvContent += `Клиент: ${clientName}\n`;
    
    // Создаем Blob и скачиваем CSV файл
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);
    
    link.setAttribute('href', url);
    link.setAttribute('download', `${fileName}.csv`);
    link.style.visibility = 'hidden';
    
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    
    // Также создаем текстовую версию для удобства
    let txtContent = `ЗАКАЗ ${clientName}\n`;
    txtContent += `Дата: ${orderDate}\n`;
    txtContent += `${'='.repeat(60)}\n\n`;
    
    cart.forEach((item, index) => {
        const itemTotal = item.price * item.quantity;
        txtContent += `${index + 1}. ${item.name}\n`;
        txtContent += `   ID: ${item.id}\n`;
        txtContent += `   Цена: ${item.price > 0 ? formatPrice(item.price) : 'Цена по запросу'}\n`;
        txtContent += `   Количество: ${item.quantity}\n`;
        if (item.quant) {
            txtContent += `   Квант: ${item.quant}\n`;
        }
        txtContent += `   Сумма: ${item.price > 0 ? formatPrice(itemTotal) : '—'}\n\n`;
    });
    
    txtContent += `${'='.repeat(60)}\n`;
    txtContent += `Итого товаров: ${cart.reduce((sum, item) => sum + item.quantity, 0)}\n`;
    txtContent += `Общая сумма: ${totalSum > 0 ? formatPrice(totalSum) : '—'}\n`;
    
    // Небольшая задержка перед скачиванием второго файла
    setTimeout(() => {
        // Скачиваем текстовый файл
        const txtBlob = new Blob([txtContent], { type: 'text/plain;charset=utf-8;' });
        const txtLink = document.createElement('a');
        const txtUrl = URL.createObjectURL(txtBlob);
        
        txtLink.setAttribute('href', txtUrl);
        txtLink.setAttribute('download', `${fileName}.txt`);
        txtLink.style.visibility = 'hidden';
        
        document.body.appendChild(txtLink);
        txtLink.click();
        document.body.removeChild(txtLink);
        
        // Очищаем URL объекты
        setTimeout(() => {
            URL.revokeObjectURL(url);
            URL.revokeObjectURL(txtUrl);
        }, 100);
        
        alert(`Заказ сохранен!\n\nСкачаны файлы:\n- ${fileName}.csv (для Excel)\n- ${fileName}.txt (текстовый формат)`);
    }, 300);
}
```

#### Особенности CSV файла:
- **Кодировка**: UTF-8 с BOM (`\uFEFF`) для правильного отображения русских символов в Excel
- **Разделитель**: точка с запятой (`;`) - стандарт для Excel в русской локали
- **Экранирование**: Кавычки удваиваются (`""`), точки с запятой заменяются на запятые
- **Столбцы**: ID товара; Наименование; Цена за единицу; Количество; Квант; Сумма
- **Итоги**: Общее количество и сумма в конце файла

#### Особенности TXT файла:
- **Кодировка**: UTF-8
- **Формат**: Читаемый текстовый формат с нумерацией
- **Информация**: Название, ID, цена, количество, квант (если есть), сумма
- **Итоги**: Общее количество товаров и общая сумма

---

## 🎨 CSS Стили (ключевые компоненты)

### Цветовая схема:
- **Основной зеленый**: `#2dbe64` (ВкусВилл)
- **Графитовый**: `#333333` (текст)
- **Красный акцент**: `#d7144b` (счетчик корзины)
- **Синий кнопка**: `#4a90e2` (кнопка скачать)
- **Фон**: `#f8f8f8` (светло-серый)

### Ключевые классы:

#### Корзина:
```css
.cart-icon-wrapper {
    position: absolute;
    top: 20px;
    right: 20px;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 5px;
}

.cart-icon {
    background: rgba(255, 255, 255, 0.2);
    border-radius: 50%;
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s;
    font-size: 1.5em;
    position: relative;
}

.cart-badge {
    position: absolute;
    top: -5px;
    right: -5px;
    background: #d7144b;
    color: white;
    border-radius: 50%;
    width: 24px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.7em;
    font-weight: bold;
}
```

#### Кнопка "В корзину":
```css
.add-to-cart-btn {
    background: #2dbe64;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1em;
    font-weight: 600;
    transition: all 0.3s;
    width: 100%;
    margin-top: 10px;
}

.add-to-cart-btn:hover {
    background: #26a855;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(45, 190, 100, 0.3);
}

.add-to-cart-btn.added {
    background: #d7144b;
}

.add-to-cart-btn.added:hover {
    background: #b8123f;
}
```

#### Кнопка скачать заказ:
```css
.download-order-btn {
    background: #4a90e2;
    color: white;
    border: none;
    padding: 15px 40px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.1em;
    font-weight: 600;
    margin-top: 10px;
    width: 100%;
    transition: all 0.3s;
}

.download-order-btn:hover {
    background: #357abd;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
}
```

---

## 🔧 Вспомогательные функции

### `formatPrice(price)`
Форматирует цену в формат с пробелами и символом тенге:
```javascript
function formatPrice(price) {
    if (price === 0) return "Цена по запросу";
    return new Intl.NumberFormat('ru-RU').format(Math.round(price)) + ' ₸';
}
```

### `showCart()` / `hideCart()`
Показывает/скрывает вид корзины:
```javascript
function showCart() {
    document.getElementById('categories-view').classList.remove('active');
    document.getElementById('products-view').classList.remove('active');
    document.getElementById('cart-view').classList.add('active');
    renderCart();
}

function hideCart() {
    document.getElementById('cart-view').classList.remove('active');
    // Возвращаемся к категориям или товарам
}
```

### `showCategory(categoryName)`
Показывает товары выбранной категории:
```javascript
function showCategory(categoryName) {
    currentCategory = categoryName;
    document.getElementById('categories-view').classList.remove('active');
    document.getElementById('products-view').classList.add('active');
    renderProducts();
}
```

### `renderProducts()`
Отображает товары текущей категории:
```javascript
function renderProducts() {
    const products = productsData[currentCategory] || [];
    const productsContainer = document.getElementById('products-container');
    
    if (products.length === 0) {
        productsContainer.innerHTML = '<p>Товары не найдены</p>';
        return;
    }
    
    let html = '';
    products.forEach(product => {
        const inCart = cart.find(item => item.id === product.id);
        const buttonText = inCart ? '✓ В корзине' : '+ В корзину';
        const buttonClass = inCart ? 'add-to-cart-btn added' : 'add-to-cart-btn';
        
        const productJson = JSON.stringify(product).replace(/"/g, '&quot;');
        
        html += `
            <div class="product-card">
                <img src="${product.image}" alt="${product.name}" onerror="this.src='placeholder.jpg'">
                <div class="product-info">
                    <h3>${product.name}</h3>
                    ${product.price > 0 ? `<div class="product-price">${formatPrice(product.price)}</div>` : '<div class="product-price">Цена по запросу</div>'}
                    ${product.stock !== undefined ? `<div class="product-stock">Остаток: ${product.stock} шт</div>` : ''}
                    <button class="${buttonClass}" data-product-id="${product.id}" data-product='${productJson}' onclick="addToCartFromButton(this)">${buttonText}</button>
                </div>
            </div>
        `;
    });
    
    productsContainer.innerHTML = html;
}
```

---

## 📝 Процесс создания нового лендинга

### Шаг 1: Подготовка данных из Excel

1. **Откройте Excel файл** с товарами
2. **Проверьте наличие обязательных колонок**:
   - ID/Артикул
   - Наименование
   - Категория
   - Ссылка на фото
3. **Определите опциональные колонки**:
   - Цена (РРЦ или другая колонка)
   - Квант
   - Остаток (если есть)
   - Другие поля

### Шаг 2: Преобразование в JSON

Создайте структуру `productsData`:
```javascript
const productsData = {
  "Категория 1": [
    {
      id: "...",
      name: "...",
      price: 0,  // или число
      image: "...",
      quant: "...",  // опционально
      stock: 0  // опционально
    }
  ],
  "Категория 2": [...]
};
```

### Шаг 3: Создание HTML структуры

1. **Скопируйте базовую структуру** из существующего лендинга
2. **Замените данные**:
   - `productsData` - ваши данные
   - `clientName` - название клиента/лендинга
   - Title в `<head>` - название страницы
3. **Настройте заголовок** в секции header

### Шаг 4: Проверка функциональности

1. **Корзина**: Добавление товаров, изменение количества
2. **Экспорт**: Скачивание CSV и TXT файлов
3. **Адаптивность**: Проверка на мобильных устройствах
4. **Кодировка**: Правильное отображение русских символов

### Шаг 5: Тестирование

1. Откройте HTML файл в браузере
2. Добавьте товары в корзину
3. Проверьте экспорт файлов
4. Проверьте на мобильном устройстве
5. Откройте CSV файл в Excel - проверьте кодировку

---

## 🚀 Быстрый старт для нового лендинга

### Команда для AI ассистента:

```
Мне нужно создать новый лендинг на основе Excel таблицы.

Excel файл: [путь к файлу]
Название лендинга: [название]
Клиент: [имя клиента]

Используй весь опыт из инструкции LANDING_CREATION_GUIDE.md:
- Структура данных из Excel
- JSON формат для товаров
- HTML структура с корзиной
- Функция экспорта в CSV/TXT файлы
- Все стили и функции корзины

Создай полный HTML файл с:
1. Встроенными CSS стилями
2. Встроенным JavaScript
3. Данными товаров из Excel
4. Полной функциональностью корзины
5. Экспортом заказа в файлы
```

---

## 📋 Чек-лист готовности лендинга

- [ ] Excel файл прочитан и преобразован в JSON
- [ ] Все обязательные поля присутствуют (id, name, image, category)
- [ ] Цены обработаны (0 = "Цена по запросу")
- [ ] HTML структура создана с тремя видами (категории, товары, корзина)
- [ ] Корзина работает (добавление, изменение количества, удаление)
- [ ] Экспорт в CSV работает (правильная кодировка UTF-8 с BOM)
- [ ] Экспорт в TXT работает
- [ ] Счетчик корзины обновляется
- [ ] Кнопки "В корзину" меняют состояние
- [ ] Адаптивный дизайн работает
- [ ] Русские символы отображаются правильно
- [ ] CSV файл открывается в Excel с правильной кодировкой

---

## 🔗 Примеры использования

### Пример 1: Лендинг для HoReCa
- **Название**: HoReCa
- **Категории**: Нон-Фуд, Бакалея, Овощи и фрукты
- **Особенность**: Фокус на альтернативное молоко

### Пример 2: Лендинг остатков на складе
- **Название**: Остатки на складе B2B на [дата]
- **Категории**: Все категории с остатками
- **Особенность**: Отображение остатков на карточках товаров

---

## 📚 Дополнительные ресурсы

- `CART_FEATURES.md` - Документация по функциональности корзины
- `README.md` - Общая документация по лендингам
- Существующие лендинги: `horeca.html`, `ost-26dec.html` - примеры реализации

---

## ⚠️ Важные замечания

1. **Кодировка CSV**: Всегда используйте BOM (`\uFEFF`) для правильного отображения в Excel
2. **Разделитель CSV**: Точка с запятой (`;`) для русской локали Excel
3. **Экранирование**: Кавычки в названиях товаров должны удваиваться
4. **localStorage**: Корзина сохраняется между сессиями браузера
5. **Имя файла**: Включайте дату и время для уникальности
6. **Задержка между скачиваниями**: 300ms между CSV и TXT файлами

---

**Последнее обновление**: 2025-12-26  
**Версия**: 1.0  
**Статус**: ✅ Готово к использованию


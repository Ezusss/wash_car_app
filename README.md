# Когда мыть машину

Flutter-приложение, которое анализирует прогноз погоды и говорит, безопасно ли мыть машину в ближайшие дни.

## Что умеет приложение

- Автоматическое определение города по GPS
- Ручной выбор города
- Оценка условий для мойки по шкале 0–100
- Цветовой индикатор: зелёный (безопасно), оранжевый (не идеально), красный (не стоит)
- Прогноз на несколько дней вперёд
- Поддержка 8 языков: русский, английский, немецкий, французский, испанский, итальянский, португальский, сербский
- Настройка единиц температуры (°C / °F)

---

## Требования

- Flutter 3.2.0 и выше
- Dart 3.2.0 и выше
- API ключ от [WeatherAPI.com](https://www.weatherapi.com/) (бесплатный)
- Android: API 29 (Android 10) и выше
- iOS: iOS 17 и выше (сборка требует Mac с Xcode)

---

## Быстрый старт

### 1. Получить API ключ

1. Зарегистрироваться на [weatherapi.com](https://www.weatherapi.com/)
2. Скопировать ключ из личного кабинета (бесплатный план, 1 млн запросов в месяц)

### 2. Клонировать репозиторий

```bash
git clone https://github.com/<твой-username>/wash_car_app.git
cd wash_car_app
```

### 3. Установить зависимости

```bash
flutter pub get
```

### 4. Запустить приложение

```bash
# Передать API ключ через dart-define:
flutter run --dart-define=WEATHER_API_KEY=твой_ключ_здесь
```

---

## Сборка APK (Android)

```bash
flutter build apk --release --dart-define=WEATHER_API_KEY=твой_ключ_здесь
```

Готовый файл: `build/app/outputs/flutter-apk/app-release.apk`

Для меньшего размера (только arm64, большинство современных телефонов):

```bash
flutter build apk --release --target-platform android-arm64 --dart-define=WEATHER_API_KEY=твой_ключ_здесь
```

---

## Сборка для iOS (нужен Mac с Xcode)

### Требования на Mac

- macOS с установленным Xcode (последняя стабильная версия)
- Flutter SDK для macOS — [инструкция установки](https://docs.flutter.dev/get-started/install/macos)
- Xcode Command Line Tools: `xcode-select --install`
- CocoaPods: `sudo gem install cocoapods`

### Шаги

```bash
# 1. Клонировать репозиторий
git clone https://github.com/<username>/wash_car_app.git
cd wash_car_app

# 2. Установить зависимости Flutter
flutter pub get

# 3. Установить зависимости iOS
cd ios && pod install && cd ..

# 4. Запустить на подключённом iPhone (разработческий режим)
flutter run -d <device-id> --dart-define=WEATHER_API_KEY=твой_ключ_здесь

# Посмотреть список доступных устройств:
flutter devices
```

### Собрать IPA (для распространения через TestFlight или прямой установки)

```bash
flutter build ios --release --dart-define=WEATHER_API_KEY=твой_ключ_здесь
```

После этого открыть проект в Xcode:

```bash
cd ios && xed .
```

В Xcode:
1. Выбрать `Runner` → `Any iOS Device (arm64)`
2. `Product` → `Archive`
3. В окне архивов: `Distribute App` → выбрать способ распространения

> Для установки на свой iPhone без App Store достаточно просто подключить телефон и нажать Run в Xcode. Apple Developer аккаунт при этом не обязателен (бесплатный подходит, но придётся переподписывать каждые 7 дней).

---

## Структура проекта

```
lib/
├── core/
│   ├── constants.dart          # Константы, цвета, пороговые значения
│   └── errors.dart             # Классы ошибок
├── data/
│   ├── api/
│   │   ├── location_service.dart   # Геолокация
│   │   └── weather_service.dart    # Запросы к WeatherAPI
│   ├── cache/
│   │   └── weather_cache.dart      # Кэширование данных
│   └── models/
│       └── weather_model.dart      # Модели данных
├── domain/
│   └── usecases/
│       └── wash_recommendation_usecase.dart  # Логика рекомендаций
├── presentation/
│   ├── providers/
│   │   └── weather_providers.dart  # Riverpod провайдеры
│   ├── screens/
│   │   ├── home_screen.dart        # Главный экран
│   │   └── settings_screen.dart    # Настройки
│   └── widgets/
│       ├── recommendation_card.dart
│       ├── weather_details.dart
│       ├── wash_score_details.dart
│       └── forecast_timeline.dart
├── l10n/                           # Локализации (ARB файлы)
└── main.dart
```

---

## Логика оценки

Приложение рассчитывает оценку от 0 до 100:

| Условие | Баллы |
|---|---|
| Нет дождя в ближайшие 24 часа | +40 |
| Нет дождя в ближайшие 48 часов | +25 |
| Ясно или облачно | +15 |
| Низкая влажность | +10 |
| Слабый ветер | +10 |
| Гроза | −70 |
| Ожидается дождь | −50 |
| Снег | −40 |
| Пыльная буря | −20 |

- **80–100** — безопасно мыть
- **50–79** — не идеально, подождать
- **0–49** — не стоит

---

## Зависимости

- `flutter_riverpod` — управление состоянием
- `geolocator` — геолокация
- `http` — HTTP запросы
- `shared_preferences` — локальное хранение настроек
- `intl` — интернационализация
- `google_mobile_ads` — баннерная реклама
- `firebase_core` / `firebase_analytics` — аналитика

---

## Лицензия

MIT

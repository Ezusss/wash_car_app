# When To Wash A Car?

A Flutter app that analyzes the weather forecast and tells you whether it's a good time to wash your car.

## Features

- Automatic location detection via GPS
- Manual city search
- Wash score from 0 to 100 with color indicator
- Multi-day forecast
- Supports 8 languages: English, Russian, German, French, Spanish, Italian, Portuguese, Serbian
- Temperature units: °C / °F

## Tech Stack

- Flutter + Dart
- Riverpod — state management
- REST API backend — [wash_car_backend](https://github.com/Ezusss/wash_car_backend)
- WeatherAPI.com — weather data
- Firebase Analytics
- Clean Architecture

## Scoring Logic

| Condition | Points |
|---|---|
| No rain in next 24h | +40 |
| Clear or partly cloudy | +15 |
| Low humidity | +10 |
| Low wind | +10 |
| Rain expected | −50 |
| Thunderstorm | −70 |
| Snow | −40 |

- **80–100** — great time to wash
- **50–79** — not ideal, consider waiting
- **0–49** — don't wash

## Getting Started

```bash
git clone https://github.com/Ezusss/wash_car_app.git
cd wash_car_app
flutter pub get
flutter run
```

## License

MIT
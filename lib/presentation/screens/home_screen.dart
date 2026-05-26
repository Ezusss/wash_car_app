import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wash_car_app/l10n/app_localizations.dart';
import 'package:wash_car_app/presentation/providers/weather_providers.dart';
import 'package:wash_car_app/presentation/widgets/forecast_timeline.dart';
import 'package:wash_car_app/presentation/widgets/recommendation_card.dart';
import 'package:wash_car_app/presentation/widgets/wash_score_details.dart';
import 'package:wash_car_app/presentation/widgets/weather_details.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  DateTime? _lastFetchedDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final today = DateTime.now();
      // Refresh if this is the first open or if the day has changed since last fetch
      final lastDate = _lastFetchedDate;
      if (lastDate == null ||
          lastDate.day != today.day ||
          lastDate.month != today.month ||
          lastDate.year != today.year) {
        ref.invalidate(weatherForecastProvider);
        _lastFetchedDate = today;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final recommendationAsync = ref.watch(washRecommendationProvider);
    final forecastAsync = ref.watch(weatherForecastProvider);
    final scoresAsync = ref.watch(forecastScoresProvider);
    final selectedDay = ref.watch(selectedForecastDayProvider);
    final recommendationUseCase = ref.watch(washRecommendationUseCaseProvider);

    // Track the date of the most recent successful fetch
    forecastAsync.whenData((f) {
      if (f != null) _lastFetchedDate = f.lastUpdated;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(weatherForecastProvider);
                await ref.read(weatherForecastProvider.future);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: recommendationAsync.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            l10n.errorLoadingWeather(error.toString()),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ref.invalidate(weatherForecastProvider),
                            child: Text(l10n.retry),
                          ),
                        ],
                      ),
                    ),
                    data: (recommendation) {
                      if (recommendation == null) {
                        return Center(child: Text(l10n.unableToLoadWeather));
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RecommendationCard(
                            recommendation: selectedDay != null
                                ? recommendationUseCase.getRecommendationForDay(selectedDay)
                                : recommendation,
                          ),
                          const SizedBox(height: 24),
                          forecastAsync.whenData((forecast) {
                            if (forecast == null) return const SizedBox.shrink();
                            return WashScoreDetails(
                              forecast: forecast,
                              selectedDay: selectedDay,
                            );
                          }).value ?? const SizedBox.shrink(),
                          const SizedBox(height: 24),
                          forecastAsync.whenData((forecast) {
                            if (forecast == null) return const SizedBox.shrink();
                            return WeatherDetails(forecast: forecast);
                          }).value ?? const SizedBox.shrink(),
                          const SizedBox(height: 24),
                          Text(
                            l10n.tenDayForecast,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          scoresAsync.whenData((scores) {
                            if (scores.isEmpty) return const SizedBox.shrink();
                            return forecastAsync.whenData((forecast) {
                              return ForecastTimeline(
                                scores: scores,
                                forecastDays: forecast?.forecast,
                                selectedDay: selectedDay,
                                onDaySelected: (day) {
                                  ref.read(selectedForecastDayProvider.notifier).state = day;
                                },
                              );
                            }).value ??
                                ForecastTimeline(scores: scores);
                          }).value ?? const SizedBox.shrink(),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const _BannerAdWidget(),
        ],
      ),
    );
  }
}

class _BannerAdWidget extends StatefulWidget {
  const _BannerAdWidget();

  @override
  State<_BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<_BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  // Test ad unit IDs — replace with production IDs before release
  static String get _adUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    final ad = BannerAd(
      adUnitId: _adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _isLoaded = true),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    );
    ad.load();
    _bannerAd = ad;
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) return const SizedBox.shrink();
    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}

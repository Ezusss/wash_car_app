package com.ezudev.washcar.wash_car_app

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.util.Log

class HomeWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.home_widget_layout)

            // Get stored data from HomeWidget plugin preferences
            val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
            // Read raw values and coerce to expected types to match HomeWidgetPlugin storage
            val all = prefs.all

            val scoreAny = all["score"]
            var score = when (scoreAny) {
                is Int -> scoreAny
                is Long -> scoreAny.toInt()
                is String -> scoreAny.toIntOrNull() ?: 0
                else -> 0
            }

            var status = all["status"]?.toString() ?: "unknown"
            var recommendation = all["recommendation"]?.toString() ?: "Loading..."
            var location = all["location"]?.toString() ?: "Unknown"

            val tempAny = all["tempC"]
            var tempC = when (tempAny) {
                is Float -> tempAny
                is Double -> tempAny.toFloat()
                is Long -> java.lang.Double.longBitsToDouble(tempAny).toFloat()
                is Int -> tempAny.toFloat()
                is String -> tempAny.toFloatOrNull() ?: 0f
                else -> 0f
            }

            val humidityAny = all["humidity"]
            var humidity = when (humidityAny) {
                is Int -> humidityAny
                is Long -> humidityAny.toInt()
                is String -> humidityAny.toIntOrNull() ?: 0
                else -> 0
            }

            // Diagnostic logs: show raw prefs and parsed values
            try {
                Log.d("HomeWidgetProvider", "prefs all: $all")
                Log.d("HomeWidgetProvider", "parsed score=$score, status=$status, recommendation=$recommendation, location=$location, tempC=$tempC, humidity=$humidity")
            } catch (e: Exception) {
                Log.e("HomeWidgetProvider", "Error logging prefs", e)
            }

            // If values look like missing/loading, try fallback shared prefs names
            val isMissing = (recommendation == "Loading..." || score == 0)
            var prefsSource = "HomeWidgetPreferences"
            if (isMissing) {
                val fallbackNames = listOf("FlutterSharedPreferences", "${context.packageName}_preferences", "home_widget_preference")
                for (name in fallbackNames) {
                    try {
                        val alt = context.getSharedPreferences(name, Context.MODE_PRIVATE)
                        if (alt != null && alt.all.isNotEmpty()) {
                            val altAll = alt.all
                            if (altAll.containsKey("recommendation") || altAll.containsKey("score")) {
                                // parse same way as above
                                val altScoreAny = altAll["score"]
                                val altScore = when (altScoreAny) {
                                    is Int -> altScoreAny
                                    is Long -> altScoreAny.toInt()
                                    is String -> altScoreAny.toIntOrNull() ?: score
                                    else -> score
                                }
                                val altRecommendation = altAll["recommendation"]?.toString() ?: recommendation
                                val altStatus = altAll["status"]?.toString() ?: status
                                val altLocation = altAll["location"]?.toString() ?: location
                                val altTempAny = altAll["tempC"]
                                val altTemp = when (altTempAny) {
                                    is Float -> altTempAny
                                    is Double -> altTempAny.toFloat()
                                    is Long -> java.lang.Double.longBitsToDouble(altTempAny).toFloat()
                                    is Int -> altTempAny.toFloat()
                                    is String -> altTempAny.toFloatOrNull() ?: tempC
                                    else -> tempC
                                }
                                val altHumidityAny = altAll["humidity"]
                                val altHumidity = when (altHumidityAny) {
                                    is Int -> altHumidityAny
                                    is Long -> altHumidityAny.toInt()
                                    is String -> altHumidityAny.toIntOrNull() ?: humidity
                                    else -> humidity
                                }

                                // override values
                                if (altAll.containsKey("score")) score = altScore
                                if (altAll.containsKey("recommendation")) recommendation = altRecommendation
                                if (altAll.containsKey("status")) status = altStatus
                                if (altAll.containsKey("location")) location = altLocation
                                tempC = altTemp
                                humidity = altHumidity
                                prefsSource = name
                                Log.d("HomeWidgetProvider", "Used fallback prefs: $name, altAll=$altAll")
                                break
                            }
                        }
                    } catch (e: Exception) {
                        Log.w("HomeWidgetProvider", "Cannot read fallback prefs $name", e)
                    }
                }
            }

            Log.d("HomeWidgetProvider", "Final values from $prefsSource: score=$score, recommendation=$recommendation, status=$status, location=$location, tempC=$tempC, humidity=$humidity")

            // Update widget views
            views.setTextViewText(R.id.widget_recommendation, recommendation)
            views.setTextViewText(R.id.widget_score, "$score/100")
            views.setTextViewText(R.id.widget_location, location)
            views.setTextViewText(R.id.widget_details, "Temp: ${String.format("%.1f", tempC)}°C | Humidity: $humidity%")

            // Set status color based on status
            val color = when (status) {
                "safe" -> context.resources.getColor(android.R.color.holo_green_dark, null)
                "warning" -> context.resources.getColor(android.R.color.holo_orange_dark, null)
                "unsafe" -> context.resources.getColor(android.R.color.holo_red_dark, null)
                else -> context.resources.getColor(android.R.color.darker_gray, null)
            }
            views.setInt(R.id.widget_status_indicator, "setBackgroundColor", color)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

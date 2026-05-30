package com.ezudev.washcar.wash_car_app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.graphics.Color
import android.widget.RemoteViews

class HomeWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.home_widget_layout)

            val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
            val all = prefs.all

            val status = all["status"]?.toString() ?: "unknown"
            val scoreAny = all["score"]
            val score = when (scoreAny) {
                is Int -> scoreAny
                is Long -> scoreAny.toInt()
                is String -> scoreAny.toIntOrNull() ?: -1
                else -> -1
            }

            val scoreText = if (score >= 0) "$score" else "—"

            val bgColor = when (status) {
                "safe"    -> Color.parseColor("#2E7D32") // green 800
                "warning" -> Color.parseColor("#E65100") // orange 900
                "unsafe"  -> Color.parseColor("#B71C1C") // red 900
                else      -> Color.parseColor("#37474F") // blue-grey 800
            }

            views.setInt(R.id.widget_root, "setBackgroundColor", bgColor)
            views.setTextViewText(R.id.widget_score, scoreText)

            // Tap opens the app
            val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
            if (launchIntent != null) {
                val pi = PendingIntent.getActivity(
                    context, 0, launchIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                views.setOnClickPendingIntent(R.id.widget_root, pi)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}

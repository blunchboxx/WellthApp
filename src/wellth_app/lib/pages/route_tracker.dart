// lib/navigation/route_tracker.dart
import 'package:flutter/widgets.dart';

class RouteTracker extends NavigatorObserver {
  String? lastRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      lastRoute = route.settings.name;
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute?.settings.name != null) {
      lastRoute = previousRoute!.settings.name;
    }
  }
}

/// Expose a single instance that you register in your MaterialApp...
final RouteTracker routeTracker = RouteTracker();

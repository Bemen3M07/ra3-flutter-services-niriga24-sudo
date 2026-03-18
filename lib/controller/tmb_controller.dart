import 'package:flutter/material.dart';

import '../data/tmb_http_service.dart';
import '../model/tmb_models.dart';

class TmbController extends ChangeNotifier {
  TmbController({TmbHttpService? service}) : _service = service ?? TmbHttpService();

  final TmbHttpService _service;

  bool isLoadingLines = false;
  bool isLoadingStops = false;
  bool isLoadingArrivals = false;
  String? errorMessage;

  List<TmbLine> lines = [];
  List<TmbStop> stops = [];
  List<TmbArrival> arrivals = [];

  Future<void> loadBusLines() async {
    isLoadingLines = true;
    errorMessage = null;
    notifyListeners();

    try {
      lines = await _service.getBusLines();
    } catch (e) {
      lines = [];
      errorMessage = e.toString();
    } finally {
      isLoadingLines = false;
      notifyListeners();
    }
  }

  Future<void> loadStops() async {
    isLoadingStops = true;
    errorMessage = null;
    notifyListeners();

    try {
      stops = await _service.getStops();
    } catch (e) {
      stops = [];
      errorMessage = e.toString();
    } finally {
      isLoadingStops = false;
      notifyListeners();
    }
  }

  Future<void> loadArrivalsByStopCode(String stopCode) async {
    isLoadingArrivals = true;
    errorMessage = null;
    notifyListeners();

    try {
      arrivals = await _service.getArrivalsByStopCode(stopCode);
    } catch (e) {
      arrivals = [];
      errorMessage = e.toString();
    } finally {
      isLoadingArrivals = false;
      notifyListeners();
    }
  }
}
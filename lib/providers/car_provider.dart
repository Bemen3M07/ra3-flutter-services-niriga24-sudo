import 'package:flutter/cupertino.dart';
import '../data/car_http_service.dart';
import '../model/car_model.dart';

class CarProvider extends ChangeNotifier{
  List<Car> carsModel = [];
  CarHttpService carHttpService = CarHttpService();
  bool isLoading = false;
  bool hasError = false;

  Future<void> getCarsData() async{
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      carsModel = await carHttpService.getCars();
    } catch (_) {
      carsModel = [];
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
import 'package:get/get.dart';

class HomeController extends GetxController {
  int index = 0;

  void updateIndex(int ind) {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        index = ind;
        update();
      },
    );
  }
}

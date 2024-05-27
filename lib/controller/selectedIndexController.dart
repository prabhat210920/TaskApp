import 'package:get/get.dart';

class SelectedIndexController extends GetxController {
  var selectedIndex = 0.obs;

  void updateSelectedIndex(int newIndex) {
    selectedIndex.value = newIndex;
  }



}

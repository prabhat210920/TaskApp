import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a provider for the selected index
final selectedIndexProvider = StateNotifierProvider<SelectedIndexNotifier, int>((ref) {
  return SelectedIndexNotifier();
});

class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier() : super(0);

  void updateSelectedIndex(int index) {
    state = index;
  }
}

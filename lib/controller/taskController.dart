import 'package:get/get.dart';
import 'package:taskapp/database/sqflite.dart';
import 'package:taskapp/model/task.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks({int? selectedIndex}) async {
    try {
      final allTasks = await DatabaseHelper().getTasks();
      final currentDate = selectedIndex != null ? DateTime.now().add(Duration(days: selectedIndex)) : DateTime.now();
      final filteredTasks = allTasks.where((task) {
        final taskStartDate = DateTime.parse(task.startDate);
        final taskEndDate = DateTime.parse(task.endDate);
        return currentDate.isAfter(taskStartDate) && currentDate.isBefore(taskEndDate);
      }).toList();
      taskList.value = filteredTasks;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await DatabaseHelper().insertTask(task);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await DatabaseHelper().updateTask(task);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task');
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      await DatabaseHelper().deleteTask(taskId);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }

  void sortTasksByPriority() {
    taskList.sort((a, b) {
      final priorityOrder = {'Low': 0, 'Mid': 1, 'High': 2};
      return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
    });
  }

  void sortTasksByCompletion() {
    taskList.sort((a, b) {
      final completionOrder = {'Pending': 0, 'Done': 1};
      return completionOrder[a.status]!.compareTo(completionOrder[b.status]!);
    });
  }

  Future<void> fetchAndSortTasks({int? selectedIndex, bool sortByPriority = false, bool sortByCompletion = false}) async {
    await fetchTasks(selectedIndex: selectedIndex);
    if (sortByPriority) {
      sortTasksByPriority();
    }
    if (sortByCompletion) {
      sortTasksByCompletion();
    }
  }
}

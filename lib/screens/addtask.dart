import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/controller/taskController.dart';
import 'package:taskapp/database/sqflite.dart';
import 'package:taskapp/model/task.dart';

class TaskInputScreen extends StatefulWidget {
  @override
  _TaskInputScreenState createState() => _TaskInputScreenState();
}

class _TaskInputScreenState extends State<TaskInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskCategoryController = TextEditingController();
  final _taskStartDateController = TextEditingController();
  final _taskEndDateController = TextEditingController();
  final _taskDescriptionController = TextEditingController();

  String? _selectedPriority;

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskCategoryController.dispose();
    _taskStartDateController.dispose();
    _taskEndDateController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString().split(' ')[0]; // Format the date as you like
      });
    }
  }

  void _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final taskName = _taskNameController.text;
      final taskCategory = _taskCategoryController.text;
      final taskStartDate = _taskStartDateController.text;
      final taskEndDate = _taskEndDateController.text;
      final taskDescription = _taskDescriptionController.text;

      final task = Task(
        name: taskName,
        category: taskCategory,
        startDate: taskStartDate,
        endDate: taskEndDate,
        description: taskDescription,
        priority: _selectedPriority!,
        status: 'Pending',
      );

      // Add the task using TaskController
      try {
        await Get.find<TaskController>().addTask(task);

        // Optionally, show a snackbar or dialog to confirm the task was saved
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task saved successfully!')),
        );

        // Clear the form
        _taskNameController.clear();
        _taskCategoryController.clear();
        _taskStartDateController.clear();
        _taskEndDateController.clear();
        _taskDescriptionController.clear();
        setState(() {
          _selectedPriority = null;
        });
      } catch (e) {
        // Handle error if task addition fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add task')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        backgroundColor: const Color(0xFFffa85c).withOpacity(0.6),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(
                controller: _taskNameController,
                labelText: 'Task Name',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the task name'
                    : null,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _taskCategoryController,
                labelText: 'Task Category',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the task category'
                    : null,
              ),
              const SizedBox(height: 16),
              _buildDateField(
                controller: _taskStartDateController,
                labelText: 'Start Date',
                context: context,
              ),
              const SizedBox(height: 16),
              _buildDateField(
                controller: _taskEndDateController,
                labelText: 'End Date',
                context: context,
              ),
              const SizedBox(height: 16),
              _buildPriorityDropdown(),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _taskDescriptionController,
                labelText: 'Description',
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text('Save Task'),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFffa85c).withOpacity(0.6), // Use the custom color here
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 1.5),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        labelStyle: const TextStyle(color: Colors.black54),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      ),
      validator: validator,
      maxLines: maxLines,
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String labelText,
    required BuildContext context,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide:const BorderSide(color: Colors.black54, width: 1.5),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        labelStyle: const TextStyle(color: Colors.black54),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode()); // To prevent the keyboard from appearing
        await _selectDate(context, controller);
      },
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedPriority,
      decoration: InputDecoration(
        labelText: 'Priority',
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 1.5),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        labelStyle: const TextStyle(color: Colors.black54),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      ),
      items: ['High', 'Mid', 'Low']
          .map((priority) => DropdownMenuItem<String>(
        value: priority,
        child: Text(priority),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedPriority = value!;
        });
      },
      validator: (value) => value == null || value.isEmpty
          ? 'Please select the task priority'
          : null,
    );
  }
}

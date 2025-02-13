part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger("HomeViewModel");
  final NavigationService _navigationService = locator<NavigationService>();
  final ThemeService _themeService = locator<ThemeService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ToastService _toastService = locator<ToastService>();

  String? _uid; // Store user ID
  List<Map<String, dynamic>> _incompleteTasks = [];

  List<Map<String, dynamic>> get incompleteTasks => _incompleteTasks;

  Future<void> init() async {
    setBusy(true);
    try {
      _uid = _localStorageService.read('token');
      if (_uid != null) {
        listenToTasks();
      }
    } catch (e) {
      _toastService.showToastMessage("Error", "Something went wrong",
          type: ToastificationType.error);
      throw Exception('Error initializing HomeViewModel: $e');
    } finally {
      setBusy(false);
    }
  }

  // Listen to tasks dynamically (both incomplete and completed)
  void listenToTasks() {
    // Incomplete tasks
    _firestore
        .collection('users')
        .doc(_uid)
        .collection('tasks')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      _incompleteTasks = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'title': data['title'],
          'description': data['description'],
          'isCompleted': data['isCompleted'],
          'createdAt': data['createdAt'],
        };
      }).toList();

      notifyListeners();
    });
  }

  // Add a new task
  Future<void> createTask(String title, String description) async {
    try {
      final newTask = {
        'title': title,
        'description': description,
        'isCompleted': false,
        'createdAt': Timestamp.now(),
      };

      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('tasks')
          .add(newTask);
      _toastService.showToastMessage("Added", "Task has been Added",
          type: ToastificationType.info);
    } catch (e) {
      throw Exception('Error creating task: $e');
    }
  }

  // Mark a task as complete
  Future<void> markTaskComplete(String taskId, bool isCompleted) async {
    try {
      final taskRef = _firestore
          .collection('users')
          .doc(_uid)
          .collection('tasks')
          .doc(taskId);

      await taskRef.update({
        'isCompleted': isCompleted,
      });

      _toastService.showToastMessage("Completed", "Task has been completed",
          type: ToastificationType.success);
    } catch (e) {
      throw Exception('Error updating task status: $e');
    }
  }

  // Edit a task
  Future<void> editTask(String taskId, String title, String description) async {
    try {
      final taskRef = _firestore
          .collection('users')
          .doc(_uid)
          .collection('tasks')
          .doc(taskId);

      await taskRef.update({
        'title': title,
        'description': description,
      });
    } catch (e) {
      throw Exception('Error editing task: $e');
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('tasks')
          .doc(taskId)
          .delete();
      _toastService.showToastMessage("Deleted", "Task has been deleted",
          type: ToastificationType.info);
    } catch (e) {
      _toastService.showToastMessage("Error", e.toString(),
          type: ToastificationType.error);
    }
  }

  void goToCompletedTasks() {
    _navigationService.navigateTo(Routes.completedTaskView);
  }

  void changeTheme() {
    _themeService.updateTheme();
    notifyListeners();
  }
}

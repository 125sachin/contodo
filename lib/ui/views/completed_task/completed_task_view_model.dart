part of 'completed_task_view.dart';

class CompletedTaskViewModel extends BaseViewModel {
  final log = getLogger("CompletedTaskViewModel");
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final ToastService _toastService = locator<ToastService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _uid;
  List<Map<String, dynamic>> _completedTasks = [];

  List<Map<String, dynamic>> get completedTasks => _completedTasks;

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
      throw Exception('Error initializing CompletedTaskViewModel: $e');
    } finally {
      setBusy(false);
    }
  }

  // Listen to tasks dynamically (both incomplete and completed)
  void listenToTasks() {
    _firestore
        .collection('users')
        .doc(_uid)
        .collection('tasks')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _completedTasks = snapshot.docs.map((doc) {
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

  void markTaskIncomplete(String taskId) async {
    try {
      // Update the task status in Firestore
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('tasks')
          .doc(taskId)
          .update({'isCompleted': false});
    } catch (e) {
      log.e('Error marking task as incomplete: $e');
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
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }

  void logout() {
    try {
      _firebaseService.logout();
    } catch (e) {
      log.e(e.toString());
    }
  }
}

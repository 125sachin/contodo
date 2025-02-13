import 'package:contodo/file_exporter.dart';

@lazySingleton
class ToastService {
  BuildContext get context => StackedService.navigatorKey!.currentContext!;

  // Flag to check if a toast is already showing
  bool _isToastShowing = false;

  /// Displays a toast message with the given [title] and [description].
  /// The [duration] specifies how long the toast will be visible (default is 2 seconds).
  /// The [type] specifies the type of the toast (default is info).
  void showToastMessage(String title, String description,
      {int duration = 2, ToastificationType type = ToastificationType.info}) {
    // Check if a toast is already showing, if yes, return without showing a new one
    if (_isToastShowing) {
      return;
    }

    _isToastShowing = true; // Set flag to true as toast is about to show

    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      title: Text(title),
      description: Text(description),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: Duration(seconds: duration),
      borderRadius: BorderRadius.circular(12.r),
      showProgressBar: true,
      dragToClose: true,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
    );

    // Reset the _isToastShowing flag after the specified duration
    Future.delayed(Duration(seconds: duration), () {
      _isToastShowing = false;
    });
  }
}

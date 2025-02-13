import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contodo/core/services/firebase_services.dart';
import 'package:contodo/core/services/toast_service.dart';
import 'package:contodo/file_exporter.dart';
import 'package:flutter/cupertino.dart';

part 'completed_task_view_model.dart';
part 'completed_task_view_components.dart';

class CompletedTaskView extends StatelessWidget {
  const CompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompletedTaskViewModel>.reactive(
      viewModelBuilder: () => CompletedTaskViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.appScaffold,
          appBar: CupertinoNavigationBar(
            middle: AppText('Completed Tasks', context).heading3,
            backgroundColor: context.colorScheme.appScaffold,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: model.isBusy
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : model.completedTasks.isEmpty
                          ? Center(child: Text('No completed tasks yet!'))
                          : ListView.builder(
                              itemCount: model.completedTasks.length,
                              itemBuilder: (context, index) {
                                final task = model.completedTasks[index];
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 5.0.h),
                                  child: Dismissible(
                                    key: ValueKey(task['id']),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      color: context.colorScheme.appFailure,
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: Icon(Icons.delete,
                                          color: context.colorScheme.ogWhite),
                                    ),
                                    confirmDismiss: (direction) async {
                                      // Confirm Delete

                                      final shouldDelete =
                                          await showDialog<bool>(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          title: AppText('Delete Task', context)
                                              .heading4,
                                          content: AppText(
                                                  'Are you sure you want to delete this task?',
                                                  context)
                                              .bodyMedium,
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (shouldDelete ?? false) {
                                        model.deleteTask(task['id']);
                                      }
                                      return shouldDelete ?? false;
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0.w),
                                        ),
                                        tileColor: context.colorScheme.ogWhite,
                                        title: AppText(task['title'], context)
                                            .heading4,
                                        subtitle: AppText(
                                                task['description'], context)
                                            .bodyMedium,
                                        trailing: Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0.w),
                                          ),
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                  (Set<WidgetState> states) {
                                            if (states.contains(
                                                WidgetState.disabled)) {
                                              return context
                                                  .colorScheme.appSuccess;
                                            }
                                            return context
                                                .colorScheme.appSuccess;
                                          }),
                                          value: task['isCompleted'],
                                          onChanged: (value) {
                                            if (value == false) {
                                              model.markTaskIncomplete(
                                                  task['id']);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
                AppButton.primaryElevated(
                  bgColor: context.colorScheme.appFailure,
                  onPressed: () {
                    model.logout();
                  },
                  title: "Logout",
                  textColor: context.colorScheme.appFailure,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

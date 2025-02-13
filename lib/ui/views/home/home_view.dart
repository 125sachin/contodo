import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contodo/core/services/toast_service.dart';
import 'package:contodo/file_exporter.dart';
import 'package:flutter/cupertino.dart';

part 'home_view_model.dart';
part 'home_view_components.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.appScaffold,
          appBar: CupertinoNavigationBar(
            backgroundColor: context.colorScheme.appScaffold,
            leading: IconButton(
              icon: Icon(
                Brightness.dark == ThemeService().brightness
                    ? Icons.nightlight_rounded
                    : Icons.sunny,
                size: 25.h,
              ),
              onPressed: () {
                model.changeTheme();
              },
              tooltip: 'View Completed Tasks',
            ),
            middle: AppText('Tasks', context).heading3,
            trailing: IconButton(
              icon: Icon(
                Icons.verified,
                size: 25.h,
              ),
              onPressed: () {
                model.goToCompletedTasks();
              },
              tooltip: 'View Completed Tasks',
            ),
          ),
          body: model.isBusy
              ? Center(child: CircularProgressIndicator.adaptive())
              : model.incompleteTasks.isEmpty
                  ? Center(child: Text('No tasks yet!'))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: model.incompleteTasks.length,
                            itemBuilder: (context, index) {
                              final task = model.incompleteTasks[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.0.h,
                                ),
                                child: Dismissible(
                                  key: ValueKey(task[
                                      'id']), // Ensure unique key for each task
                                  background: Container(
                                    color: context.colorScheme.appSuccess,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Icon(Icons.edit,
                                        color: context.colorScheme.ogWhite),
                                  ),
                                  secondaryBackground: Container(
                                    color: context.colorScheme.appFailure,
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: Icon(Icons.delete,
                                        color: context.colorScheme.ogWhite),
                                  ),
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      // Edit Task
                                      model._titleController.text =
                                          task['title'];
                                      model._descriptionController.text =
                                          task['description'];
                                      await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            buildEditTaskDialog(
                                          context,
                                          model,
                                          task['id'],
                                        ),
                                      );
                                      return false;
                                    } else if (direction ==
                                        DismissDirection.endToStart) {
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
                                    }
                                    return false;
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0.w),
                                      ),
                                      tileColor: context.colorScheme.ogWhite,
                                      title: AppText(task['title'], context)
                                          .heading4,
                                      subtitle:
                                          AppText(task['description'], context)
                                              .bodyMedium,
                                      trailing: Checkbox(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0.w),
                                        ),
                                        value: task['isCompleted'],
                                        onChanged: (value) {
                                          model.markTaskComplete(
                                              task['id'], value!);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: context.colorScheme.ogWhite,
            onPressed: () {
              model._titleController.clear();
              model._descriptionController.clear();
              showDialog(
                context: context,
                builder: (context) => buildCreateTaskDialog(context, model),
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

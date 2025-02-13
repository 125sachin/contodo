part of 'home_view.dart';

Widget buildCreateTaskDialog(BuildContext context, HomeViewModel model) {
  return CupertinoAlertDialog(
    title: Text('Add Task'),
    content: Column(
      children: [
        10.verticalSpace,
        CupertinoTextField(
          controller: model._titleController,
          placeholder: 'Title',
          decoration: BoxDecoration(),
        ),
        Divider(
          thickness: 1.w,
          color: Colors.grey,
        ),
        CupertinoTextField(
          controller: model._descriptionController,
          placeholder: 'Description',
          decoration: BoxDecoration(),
        ),
      ],
    ),
    actions: [
      CupertinoDialogAction(
        isDefaultAction: false,
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel'),
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          final title = model._titleController.text.trim();
          final description = model._descriptionController.text.trim();
          if (title.isNotEmpty && description.isNotEmpty) {
            model.createTask(title, description);
            Navigator.pop(context);
          }
        },
        child: Text('Create'),
      ),
    ],
  );
}

Widget buildEditTaskDialog(
    BuildContext context, HomeViewModel model, String taskId) {
  return CupertinoAlertDialog(
    title: Text('Edit Task'),
    content: Column(
      children: [
        Column(
          children: [
            CupertinoTextField(
              controller: model._titleController,
              placeholder: 'Title',
              decoration: BoxDecoration(),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            CupertinoTextField(
              controller: model._descriptionController,
              placeholder: 'Description',
              decoration: BoxDecoration(),
            ),
          ],
        ),
      ],
    ),
    actions: [
      CupertinoDialogAction(
        isDefaultAction: false,
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel'),
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          final title = model._titleController.text.trim();
          final description = model._descriptionController.text.trim();
          if (title.isNotEmpty && description.isNotEmpty) {
            model.editTask(taskId, title, description);
            Navigator.pop(context);
          }
        },
        child: Text('Save'),
      ),
    ],
  );
}

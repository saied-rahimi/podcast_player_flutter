import 'package:flutter/material.dart';
import 'package:podcast_player/widgets/text_widget.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({this.onCreate, super.key});
  final void Function(String title)? onCreate;

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  late TextEditingController titleController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 25,
          children: [
            TitleText('Add Episode'),
            Container(
              width: 300,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.5, color: Colors.blue.shade100),
              ),
              child: TextFormField(
                cursorColor: Colors.blue.shade400,
                style: TextStyle(color: Colors.blue.shade400),

                decoration: InputDecoration(
                  hint: Text('Episode title'),

                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                controller: titleController,
                autofocus: true,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).maybePop();
                  },
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (titleController.text.isNotEmpty) {
                      widget.onCreate?.call(titleController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Title is empty!')));
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
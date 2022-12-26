import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final void Function()? ontap;
  final String title;
  final String content;
  final void Function()? onDelete;

  const CardNotes(
      {Key? key,
      this.ontap,
      required this.title,
      required this.content,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 0,
                child: Image.asset(
                  "images/note4.jpg",
                  width: 70,
                  height: 70,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 1,
                child: ListTile(
                  title: Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(content),
                  trailing: IconButton(
                    alignment: Alignment.center,
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

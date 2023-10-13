import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ItemSelectionScreen(),
    );
  }
}

class ItemSelectionScreen extends StatefulWidget {
  @override
  _ItemSelectionScreenState createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends State<ItemSelectionScreen> {
  List<Item> items = [
    Item("Item 1", false),
    Item("Item 2", false),
    Item("Item 3", false),
    Item("Item 4", false),
    Item("Item 5", false),
  ];

  int selectedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection Screen'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            tileColor: items[index].isSelected ? Colors.blue : null,
            onTap: () {
              setState(() {
                items[index].isSelected = !items[index].isSelected;
                if (items[index].isSelected) {
                  selectedCount++;
                } else {
                  selectedCount--;
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Selected Items'),
                content: Column(
                  children: [
                    for (var item in items)
                      if (item.isSelected) Text(item.name),
                    SizedBox(height: 16),
                    Text('Number of selected items: $selectedCount'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class Item {
  final String name;
  bool isSelected;

  Item(this.name, this.isSelected);
}
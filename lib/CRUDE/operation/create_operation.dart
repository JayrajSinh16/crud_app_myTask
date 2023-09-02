import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateOperation extends StatelessWidget {
  const CreateOperation({
    super.key,
    required TextEditingController snController,
    required TextEditingController nameController,
    required TextEditingController rollController,
    required TextEditingController branchController,
    required CollectionReference<Object?> items,
    required this.context,
  }) : _snController = snController, _nameController = nameController, _rollController = rollController, _branchController = branchController, _items = items;

  final TextEditingController _snController;
  final TextEditingController _nameController;
  final TextEditingController _rollController;
  final TextEditingController _branchController;
  final CollectionReference<Object?> _items;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
                  child: Text(
                    "Create your item",
                    style: TextStyle(
                      color: Color.fromARGB(255, 222, 221, 221),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
                TextField(
                  style: const TextStyle(color: Color.fromARGB(255, 203, 196, 196)),
                  keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration:
                      const InputDecoration(
                        hintStyle: TextStyle(
                        color: Color.fromARGB(255, 203, 196, 196)
                      ),
                        labelStyle: TextStyle(
                        color: Color.fromARGB(255, 203, 196, 196)
                      ),
                        labelText: 'S.No',
                         hintText: 'eg.1',
                        ),
                ),
                TextField(
                  style: const TextStyle(color: Color.fromARGB(255, 203, 196, 196)),
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 203, 196, 196)
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 203, 196, 196)
                      ),
                      labelText: 'Name', hintText: 'eg.Elon'),
                ),
                
                TextField(
                  style: const TextStyle(color: Color.fromARGB(255, 203, 196, 196)),
                  controller: _branchController,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 203, 196, 196)
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 203, 196, 196)
                      ),
                      labelText: 'Branch', hintText: 'eg.CSE'),
                ),
                TextField(
                  style: const TextStyle(color: Color.fromARGB(255, 203, 196, 196)),
                  keyboardType: TextInputType.number,
                  controller: _rollController,
                  decoration:
                      const InputDecoration(
                        hintStyle: TextStyle(
                        color: Color.fromARGB(255, 203, 196, 196)
                      ),
                        labelStyle: TextStyle(
                        color: Color.fromARGB(255, 203, 196, 196)
                      ),
                        labelText: 'Roll no:', hintText: 'eg.1'),
                ),
                const SizedBox(
                  height: 20,
                ),
          ElevatedButton(
              style:ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 187, 71)
                    ) ,
              onPressed: () async {
                final String name = _nameController.text;
                final int? sn = int.tryParse(_snController.text);
                final int? roll_no = int.tryParse(_rollController.text);
                final String branch = _branchController.text;
                if (sn != null) {
                  await _items
                      .add({"name": name, "branch": branch, "sn": sn, "roll no": roll_no});
                  _nameController.text = '';
                  _snController.text = '';
                  _rollController.text = '';
                  _branchController.text = '';

                  Navigator.of(context).pop();
                }
              },
              child: const Text("Create"))
        ],
      ),
    );
  }
}
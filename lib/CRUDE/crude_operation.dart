import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'operation/create_operation.dart';

class CRUDEoperation extends StatefulWidget {
  const CRUDEoperation({super.key});


  @override
  State<CRUDEoperation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CRUDEoperation> {

    //sign user out method
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }


  // text field controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _snController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  String searchText = '';


  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),     
        backgroundColor: const Color.fromARGB(255, 25, 42, 66),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return CreateOperation(
            snController: _snController,
            nameController: _nameController,
            rollController: _rollController,
            branchController: _branchController,
            items: _items,
            context: context
          );
        });
  }



  // for Update operation
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _rollController.text = documentSnapshot['roll no'].toString();
      _snController.text = documentSnapshot['sn'].toString();
      _branchController.text = documentSnapshot['branch'];
    }
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        backgroundColor: const Color.fromARGB(255, 25, 42, 66),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update your item",
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
                            .doc(documentSnapshot!.id)
                            .update({"name": name, "branch": branch, "sn": sn,"roll no":roll_no});
                        _nameController.text = '';
                        _snController.text = '';
                        _branchController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Update"))
              ],
            ),
          );
        });
  }


  // for delete operation
  Future<void> _delete(String productID) async {
    await _items.doc(productID).delete();

    // for snackBar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item deleted sucessfully")));
  }
  
  //search function
  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool isSearchClicked = false;
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 6, 6),
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 100, 106, 113),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),                
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      hintText: 'Search..'),
                ),
              )
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Image.asset("assets/logo_3.png",scale:3.2,),
                const SizedBox(width: 10,),
                const Text(
                  'CRUD Operation',
                    style: TextStyle(color:  Color.fromARGB(255, 255, 187, 71),),
                  ),
              ],
            ),
        actions: [
          SearchButton(),
          MyPopupMenu(),
        ],
      ),
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                .where((doc) => doc['name'].toLowerCase().contains(
                      searchText.toLowerCase(),
                    ))
                .toList();
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3/3,
                  crossAxisCount: 2,
                  ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = items[index];
                  return Card_item(documentSnapshot);
                });
          }
          return const Center(
            child: CircularProgressIndicator(color: Color.fromARGB(255, 255, 187, 71),),
          );
        },
      ),
      // Create new project button
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.blueGrey,
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 45, 65, 98),
        child: const Icon(
          Icons.add,
          size: 28,
          color:  Color.fromARGB(255, 255, 187, 71),
          ),
      ),
    );
  }

  Card Card_item(DocumentSnapshot<Object?> documentSnapshot) {
    return Card(
                  color: const Color.fromARGB(255, 19, 33, 53),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8,left: 10),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color.fromARGB(255, 255, 187, 71),
                              child: Text(
                                documentSnapshot['sn'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 50,),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: IconButton(
                              onPressed: () => _update(documentSnapshot),
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                                color: Color.fromARGB(255, 139, 139, 139),
                                )
                            ),
                          ),
                         
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: IconButton(
                              color: Colors.black,
                              onPressed: () => _delete(documentSnapshot.id),
                              icon: const Icon(
                                Icons.delete,
                                size: 18,
                                color: Color.fromARGB(255, 139, 139, 139),
                                )
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                 const Text(
                                  "Name: ",
                                  style:  TextStyle(
                                    color: Color.fromARGB(255, 139, 139, 139),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  documentSnapshot['name'],
                                  style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 203, 196, 196),
                                  fontSize: 18,
                                ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4,),
                            Row(
                              children: [
                                const Text(
                                  "Branch: ",
                                  style:  TextStyle(
                                  color: Color.fromARGB(255, 139, 139, 139),
                                  fontSize: 14,
                                ),
                                ),
                                Text(
                                  documentSnapshot['branch'].toString(),
                                  style: const TextStyle(
                                  color: Color.fromARGB(255, 203, 196, 196),
                                  fontSize: 16,
                                  ),
                                ),
                              ],                             
                            ),
                            const SizedBox(height: 4,),
                            Row(
                              children: [
                                const Text(
                                  "Roll no: ",
                                  style:  TextStyle(
                                  color: Color.fromARGB(255, 139, 139, 139),
                                  fontSize: 14,
                                ),
                                ),
                                Text(
                                  documentSnapshot['roll no'].toString(),
                                  style: const TextStyle(
                                  color: Color.fromARGB(255, 203, 196, 196),
                                  fontSize: 16,
                                  ),
                                ),
                              ],
                          )
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                );
  }

  IconButton SearchButton() {
    return IconButton(
            onPressed: () {
              setState(() {
                isSearchClicked = !isSearchClicked;
              });
            },
            icon: Icon(isSearchClicked ? Icons.close : Icons.search,color: const Color.fromARGB(255, 100, 106, 113),),
          );
  }

  PopupMenuButton<int> MyPopupMenu() {
    return PopupMenuButton<int>(
        color: const  Color.fromARGB(255, 100, 106, 113),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        const PopupMenuItem<int>(
            value: 1, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.logout,color: Colors.white,),
                Text('Sign Out',style: TextStyle(color: Colors.white),),
              ],
            )),
      ],
      onSelected: (value) {
        setState(() {
           signUserOut();
          });
      });
  }
}


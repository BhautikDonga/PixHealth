import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewMedicine extends StatefulWidget {
  final String argument;

  const ViewMedicine({Key key, this.argument}) : super(key: key);

  @override
  _ViewMedicineState createState() => _ViewMedicineState();
}

class _ViewMedicineState extends State<ViewMedicine> {
  var medicines = [];

  @override
  void initState() {
    //final DashBoard args = ModalRoute.of(context).settings.arguments;
    //final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref
        .child("Users")
        .child(widget.argument)
        .child('Medicines')
        .child('12345678')
        .once()
        .then((DataSnapshot snap) {
      var data = snap.value;
      print('Data : ${data}');
      medicines.clear();
      for (var val in data) {
        medicines.add(val);
      }
      setState(() {
        print('Length: ${medicines.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Medicines',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: medicines.length == 0
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Data loading...'),
                  ],
                ))
              : ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 16.0),
                            child: Text(
                              medicines[pos],
                              style: TextStyle(
                                fontSize: 18.0,
                                //height: 1,
                              ),
                            ),
                          ),
                        ));
                  },
                ),
        ),
      ),
    );
  }
}

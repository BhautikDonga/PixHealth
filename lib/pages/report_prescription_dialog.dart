import 'package:flutter/material.dart';

class ReportPrescriptionDialogBox extends StatefulWidget {
  ReportPrescriptionDialogBox(this._children);

  final List<Widget> _children;

  @override
  _ReportPrescriptionDialogBoxState createState() =>
      _ReportPrescriptionDialogBoxState();
}

class _ReportPrescriptionDialogBoxState
    extends State<ReportPrescriptionDialogBox> {
  int _currentIndex = 0;
  PageController controller = PageController();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: widget._children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_center_focus),
              title: Text('Reports'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              title: Text('Prescriptions'),
            ),
          ],
        ),
      ),
    );
  }
}

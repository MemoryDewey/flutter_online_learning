import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    print('I have been created!');
  }
  @override
  void deactivate() {
    super.deactivate();
    print('deactive');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      backgroundColor: Color(0xfff2f2f6),
      body: Center(
        child: Text('我的'),
      ),
    );
  }
}

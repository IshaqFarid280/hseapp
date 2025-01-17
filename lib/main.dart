import 'package:flutter/material.dart';
import 'package:hseapp/api/sheets/user_sheets_api.dart';
import 'package:hseapp/model/user.dart';
import 'package:hseapp/widgets/ButtonWidget.dart';
import 'package:hseapp/widgets/user_form_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetApi.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserFormWidget(
                onSaveduser: (user)async {
              final id = await UserSheetApi.getRowCount() + 1;
              final newUser = user.copy(id: id);
              await UserSheetApi.insert([newUser.toJson()]);

            })
            // Buttonwidget(
            //   text: 'Save',
            //   onClicked: ()async {
            //
            //
            //     insertUsers();
            //   // final user = User(name: 'ishaq', email: 'Ishaq@gmail.com ', isBeginner: true);
            //   //   await UserSheetApi.insert([user.toJson()]);
            //   }
            // )

          ],
        ),
      ),
    );

  }
  Future insertUsers() async{
    final users = [
      User(id: 1, name: 'Ishaq new', email: 'ishaqnew@gmail.com', isBeginner: true),
      User(id: 2, name: ' new', email: 'new@gmail.com', isBeginner: true),
      User(id: 3, name: ' false flag', email: 'falasnew@gmail.com', isBeginner: true),
    ];
    final jsonUsers = users.map((user) => user.toJson()).toList();
    await UserSheetApi.insert(jsonUsers);

  }
}



import 'package:flutter/material.dart';
import 'package:hseapp/model/user.dart';
import 'package:hseapp/widgets/ButtonWidget.dart';


class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSaveduser;



  const UserFormWidget({super.key, required this.onSaveduser});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();


  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late bool isBeginner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inituser();
  }
  inituser() async{
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    this.isBeginner = true;
  }
  @override
  Widget build(BuildContext context)  => Form(
    key: formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildName(),
        const SizedBox(
          height: 16,
        ),
        buildEmail(),
        const SizedBox(
          height: 16,
        ),
        buildFlutterBeginer(),
        const SizedBox(
          height: 16,
        ),
        buildSubmit(),
      ],
    ),
  );
  Widget buildName() => TextFormField(
    controller: controllerName,
    decoration: InputDecoration(
      labelText: 'Name',
      border: OutlineInputBorder(),

    ),
    validator: (value) =>
        value != null && value.isEmpty ? 'Enter Name' : null,

  ); Widget buildEmail() => TextFormField(
    controller: controllerEmail,
    decoration: InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder()
    ),
    validator: (value) =>
    value != null && !value.contains('@') ? 'Enter Email' : null,

  );
  Widget buildFlutterBeginer() => SwitchListTile(
    contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: isBeginner,
      title: Text('Is User Beginner?'),
      onChanged: (value) => setState(() => isBeginner = value),

  );
  Widget buildSubmit() => Buttonwidget(text: 'Save', onClicked: (){
    final form = formKey.currentState!;
    final isValid = form.validate();

    if(isValid){
      final user = User(name: controllerName.text, email: controllerEmail.text, isBeginner: isBeginner);
      widget.onSaveduser(user);
    }

  });
}

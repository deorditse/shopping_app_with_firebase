import 'package:firebase_clear_19/packages/ui_layout/pages/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/validate_email.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool successMessage = false;

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        successMessage = true;
      });
      // AuthController.instance.login(
      //     _emailController.text.trim(), _passwordController.text.trim());
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: Key('fieldEmail'),
            //for testing
            validator: (value) {
              print(_emailController.text);
              if (value == '') return 'Введите email';
              if (!validateEmail(value!)) //проверка на совпадения символам
                return 'Поле email содержит недопустимые символы';
              return null;
            },
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration:
                InputDecoration(labelText: 'Email', hintText: 'test@test.com'),
          ),
          TextFormField(
            controller: _passwordController,
            key: const Key('fieldPassword'),
            validator: (value) {
              if (value == '') return 'Введите пароль';
              //if (value.length.toInt() > 11) return 'Некорректный номер телефона';
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Пароль',
              hintText: '*****',
            ),
            keyboardType: TextInputType.visiblePassword,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            obscureText: true,
          ),
          ElevatedButton(
            child: Text('Войти'),
            onPressed: _submit,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () {
              AuthController.instance.signInWithGoogle();
            },
            child: const Text("Sign In with Google"),
          ),
          if (successMessage) Text('Добро пожаловать!'),
        ],
      ),
    );
  }
}

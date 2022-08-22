import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../utils/validate_email.dart';
import 'login_form.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSuccess = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      //сначала проверим прохождение валидации
      setState(() {
        _isSuccess = true;
      });
      AuthController.instance.register(
          _emailController.text.trim(), _passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            key: Key('fieldName'), //for testing
            decoration: InputDecoration(labelText: 'First name'),
            // validator: (value) {
            //   if (value == '') return 'Введите имя';
            //   return null;
            // },
          ),
          // TextFormField(
          //   key: Key('fieldLastName'),
          //   decoration: InputDecoration(labelText: 'Last name'),
          //   validator: (value) {
          //     if (value == '') return 'Введите фамилию';
          //     return null;
          //   },
          // ),
          TextFormField(
            key: Key('fieldPhone'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration:
                InputDecoration(labelText: 'Phone', hintText: '89252776324'),
            // validator: (value) {
            //   if (value == '') return 'Заполните поле телефон';
            //   return null;
            // },
          ),

          TextFormField(
            controller: _emailController,
            key: Key('fieldEmail'),
            decoration:
                InputDecoration(labelText: 'Email', hintText: 'test@test.com'),
            // validator: (value) {
            //   if (value == '') return 'Заполните поле email';
            //   if (!validateEmail(value!)) return 'Емейл не корректный';
            //   return null;
            // },
          ),
          TextFormField(
            controller: _passwordController,
            key: const Key('fieldPassword'),
            // validator: (value) {
            //   if (value == '') return 'Введите пароль';
            //   //if (value.length.toInt() > 11) return 'Некорректный номер телефона';
            //   return null;
            // },
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
            child: Text('Зарегистрироваться'),
            onPressed: _handleSubmit,
          ),
          const SizedBox(height: 30),

          if (_isSuccess) Text('Вы успешно зарегистрировались')
        ],
      ),
    );
  }
}

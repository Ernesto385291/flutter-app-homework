import 'package:flutter/material.dart';
import 'package:my_app/constants.dart' as constants;
import 'package:my_app/widgets/snackbar.dart';
import 'package:my_app/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Add the toggle for password visibility
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            newMethod(size, 'Email', _emailController),
            SizedBox(height: 16.0),
            newMethod(size, 'Password', _passwordController, isPassword: true),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // If the password and the user are correct we change the screen to the home screen if not we show an error message
                if (_emailController.text == constants.adminEmail &&
                    _passwordController.text == constants.adminPassword) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } else {
                  showSnackBar(context, 'Invalid email or password', 2);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: constants.purple,
                foregroundColor: constants.white,
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField newMethod(
    Size size,
    String label,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: isPassword
            ? Padding(
                padding: EdgeInsets.only(right: size.width * 0.02),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              )
            : null,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: size.width * 0.04),
          child: Icon(isPassword ? Icons.lock : Icons.email),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
    );
  }
}

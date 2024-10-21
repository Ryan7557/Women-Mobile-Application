import 'package:empower_women/components/my_textfield.dart';
import 'package:empower_women/pages/dashboard.dart';
import 'package:empower_women/utils/snackbar_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void _signUp() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {'username': usernameController.text.toLowerCase()},
      );
      setState(() {
        _isLoading = false;
      });

      _navigateToLogin();
    } on AuthException catch (e) {
      context.showSnackbar(message: e.message, backgroundColor: Colors.amber);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      context.showSnackbar(
          message: e.toString(), backgroundColor: Colors.amber);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const DashboardPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_isLoading) ...[
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                ],
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(height: 50),
                Text(
                  'Hello Girl, Welcome To A Ladies Only Space',
                  style: GoogleFonts.bebasNeue(fontSize: 16),
                ),
                const SizedBox(height: 25),

                MyTextfield(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                  validator: (value) => validateUsername(value),
                ),

                const SizedBox(height: 10),

                // Email TextField
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                // Button for Login
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.grey,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                  ),
                  child: Text(
                    'Register',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    _navigateToLogin();
                  },
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.blue[700]),
                  child: Text(
                    "Already Have An Account",
                    style: GoogleFonts.bebasNeue(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username cannot be empty.';
  }

  final usernameRegEx =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$');
  if (!usernameRegEx.hasMatch(value)) {
    return 'Username must contain letters, numbers, and symbols.';
  }
  return null;
}

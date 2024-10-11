import 'package:empower_women/components/my_textfield.dart';
import 'package:empower_women/pages/dashboard.dart';
import 'package:empower_women/pages/register.dart';
import 'package:empower_women/utils/snackbar_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await supabase.auth.signInWithPassword(
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });

      _navigateToDashoard();
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

  void _navigateToDashoard() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()),
      (route) => false,
    );
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
                  'Welcome Back Girl, You\'ve Been Missed!',
                  style: GoogleFonts.bebasNeue(fontSize: 16),
                ),
                const SizedBox(height: 25),

                // email TextField
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
                  onPressed: _isLoading ? null : _signIn,
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.grey,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                  ),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        const Register(),
                      ),
                    );
                  },
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.blue[700]),
                  child: Text(
                    "No Account, Register Here",
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

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

import 'package:flutter/material.dart';

import 'widgets/header_banner.dart';
import 'widgets/login_form.dart';
import 'widgets/profile_card.dart';

void main() {
  runApp(const F2LayoutApp());
}

class F2LayoutApp extends StatefulWidget {
  const F2LayoutApp({super.key});

  @override
  State<F2LayoutApp> createState() => _F2LayoutAppState();
}

class _F2LayoutAppState extends State<F2LayoutApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF0468D7);

    return MaterialApp(
      title: 'F2 - 231A010025',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: LoginPage(onToggleTheme: _toggleTheme),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({required this.onToggleTheme, super.key});

  final VoidCallback onToggleTheme;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberLogin = false;
  bool _obscurePassword = true;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              HeaderBanner(onToggleTheme: widget.onToggleTheme),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 700;
                  final form = LoginForm(
                    rememberLogin: _rememberLogin,
                    obscurePassword: _obscurePassword,
                    onRememberChanged: (value) {
                      setState(() => _rememberLogin = value);
                    },
                    onPasswordVisibilityChanged: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    onLogin: () => _showMessage(
                      'Đăng nhập mô phỏng thành công. Xin chào Phú!',
                    ),
                    onForgotPassword: () => _showMessage(
                      'Vui lòng liên hệ quản trị viên để đặt lại mật khẩu.',
                    ),
                    onSchoolLogin: () => _showMessage(
                      'Đăng nhập tài khoản trường hiện là bản mô phỏng.',
                    ),
                    onRegister: () => _showMessage(
                      'Vui lòng liên hệ văn phòng khoa để đăng ký.',
                    ),
                  );
                  const profile = ProfileCard();
                  final content = isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: form),
                            const SizedBox(width: 24),
                            const Expanded(flex: 2, child: profile),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [form, const SizedBox(height: 24), profile],
                        );

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1120),
                        child: content,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

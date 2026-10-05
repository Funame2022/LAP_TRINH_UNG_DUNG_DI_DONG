import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.rememberLogin,
    required this.obscurePassword,
    required this.onRememberChanged,
    required this.onPasswordVisibilityChanged,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onSchoolLogin,
    required this.onRegister,
    super.key,
  });

  final bool rememberLogin;
  final bool obscurePassword;
  final ValueChanged<bool> onRememberChanged;
  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onSchoolLogin;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Đăng nhập hệ thống',
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Nhập MSSV và mật khẩu để tiếp tục',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 22),
        const TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Mã số sinh viên',
            hintText: 'Ví dụ: 231A010025',
            prefixIcon: Icon(Icons.badge_outlined),
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          obscureText: obscurePassword,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              tooltip: obscurePassword ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
              onPressed: onPasswordVisibilityChanged,
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Checkbox(
              value: rememberLogin,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) => onRememberChanged(value ?? false),
            ),
            const Flexible(
              flex: 2,
              child: Text(
                'Ghi nhớ đăng nhập',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: onForgotPassword,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: onLogin,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 13),
            child: Text(
              'ĐĂNG NHẬP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'hoặc',
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 18),
        OutlinedButton.icon(
          onPressed: onSchoolLogin,
          icon: const Icon(Icons.school_outlined),
          label: const Text('Đăng nhập bằng tài khoản trường'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(child: Text('Chưa có tài khoản?')),
            TextButton(onPressed: onRegister, child: const Text('Đăng ký')),
          ],
        ),
      ],
    );
  }
}

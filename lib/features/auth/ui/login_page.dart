import 'package:flutter/material.dart';
import '../../../core/theme/app_design_system.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDesignSystem.spacingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '로그인 / 회원가입',
              style: TextStyle(
                fontSize: AppDesignSystem.fontSizeTitle,
                fontWeight: AppDesignSystem.fontWeightBold,
                color: AppDesignSystem.textTitle,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDesignSystem.spacingXl),
            TextField(
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: '이메일을 입력하세요',
              ),
            ),
            const SizedBox(height: AppDesignSystem.spacingMd),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력하세요',
              ),
            ),
            const SizedBox(height: AppDesignSystem.spacingLg),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('로그인'),
            ),
            const SizedBox(height: AppDesignSystem.spacingMd),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppDesignSystem.borderDefault),
              ),
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}

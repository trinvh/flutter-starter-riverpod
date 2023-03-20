import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inapps_picasso/feature/auth/provider/auth_provider.dart';
import 'package:inapps_picasso/shared/http/app_exception.dart';
import 'package:inapps_picasso/shared/route/app_router.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _widgetResult(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    return state.maybeWhen(
      error: (AppException error) {
        return error.whenOrNull(errorWithMessage: (String message) {
              return Text(message);
            }) ??
            const Text('');
      },
      orElse: () {
        return const Text('');
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 150),
            Text(
              'sign_in'.tr(),
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            _widgetResult(context, ref),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'email'.tr(),
                    ),
                    controller: _usernameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'password'.tr(),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      _widgetSignInButton(context, ref),
                      const SizedBox(height: 30),
                      _widgetSignUpButton(context, ref),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetSignInButton(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.maybeWhen(loading: () => true, orElse: () => false);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : () {
          ref
              .read(authNotifierProvider.notifier)
              .login(_usernameController.text, _passwordController.text);
        },
        child: Text('sign_in'.tr()),
      ),
    );
  }

  Widget _widgetSignUpButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ref.read(routerProvider).push(SignUpRoute.path);
        },
        child: Text('sign_up'.tr()),
      ),
    );
  }
}

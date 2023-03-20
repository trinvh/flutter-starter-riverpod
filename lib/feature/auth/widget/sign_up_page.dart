import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inapps_picasso/feature/auth/provider/auth_provider.dart';
import 'package:inapps_picasso/shared/http/app_exception.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
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
            child: Column(children: <Widget>[
              const SizedBox(height: 150),
              Text(
                'sign_up'.tr(),
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              _widgetResult(context, ref),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'name'.tr(),
                      ),
                      controller: _nameController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'email'.tr(),
                      ),
                      controller: _emailController,
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
                          _widgetSignUpButton(context, ref),
                          const SizedBox(height: 30),
                          _widgetSignInButton(context, ref),
                        ]),
                  ],
                ),
              )
            ])));
  }

  Widget _widgetSignInButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: Text('sign_in'.tr()),
        ));
  }

  Widget _widgetSignUpButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            ref.read(authNotifierProvider.notifier).signUp(_nameController.text,
                _emailController.text, _passwordController.text);
          },
          child: const Text('sign_up').tr(),
        ));
  }
}

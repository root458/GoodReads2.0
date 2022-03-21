import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_reads_app/authpages/google_sigin_in_cubit/google_sign_in_cubit.dart';
import 'package:good_reads_app/utils/_index.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .7,
          height: MediaQuery.of(context).size.height * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircleAvatar(
                backgroundColor: TrainingTheme.primaryColor,
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Sign in with Google'),
                  const SizedBox(
                    height: 13,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GoogleSignInCubit>().signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: TrainingTheme.primaryColor,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .5, 50),
                    ),
                    child: BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
                      listener: (contextOne, state) {
                        state.when(
                            initial: () {},
                            loading: () {},
                            loaded: () => Navigator.pushReplacementNamed(
                                  contextOne,
                                  TrainingRouter.homeRoute,
                                ),
                            error: (lst) {},);
                      },
                      builder: (context, state) {
                        return state.when(
                          initial: () => const Text('Sign In'),
                          loading: () => const Text('Loading...'),
                          loaded: () {
                            return const Text('Sign In');
                          },
                          error: (errorLst) => const Text('Try again'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_reads_app/form/components/form_widget.dart';
import 'package:good_reads_app/form/cubit/post_book_cubit.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    final postBookCubit = BlocProvider.of<PostBookCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Speak to us'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<PostBookCubit, PostBookState>(
            builder: (BuildContext context, PostBookState state) {
              return state.when(
                initial: () => FormWidget(
                    pageContext: context, postBookCubit: postBookCubit,),
                sending: () => const CircularProgressIndicator(),
                sent: (books) => const Text('Successfully sent'),
                error: Text.new,
              );
            },
          ),
        ),
      ),
    );
  }
}

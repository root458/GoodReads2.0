import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_reads_app/form/cubit/post_book_cubit.dart';
import 'package:good_reads_app/models/_index.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  void initState() {
    super.initState();

    context.read<PostBookCubit>().loadFormPage();
  }

  @override
  Widget build(BuildContext context) {
    final postBookCubit = BlocProvider.of<PostBookCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Speak to us'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<PostBookCubit, PostBookState>(
            builder: (BuildContext context, PostBookState state) {
              return state.when(
                initial: () => _buildForm(context, postBookCubit),
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

Widget _buildForm(BuildContext pageContext, PostBookCubit postBookCubit) {
  return FormWidget(
    pageContext: pageContext,
    postBookCubit: postBookCubit,
  );
}

class FormWidget extends StatefulWidget {
  const FormWidget({
    Key? key,
    required this.pageContext,
    required this.postBookCubit,
  }) : super(key: key);
  final BuildContext pageContext;
  final PostBookCubit postBookCubit;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    // Text fields
    var author = '';
    var title = '';
    var year = '';

    return SizedBox(
      width: MediaQuery.of(widget.pageContext).size.width * .7,
      height: MediaQuery.of(widget.pageContext).size.height * .7,
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              maxLines: 2,
              decoration: const InputDecoration(hintText: 'Author name'),
              validator: (value) => value!.isEmpty ? 'Enter author name' : null,
              onChanged: (val) {
                setState(() {
                  author = val;
                });
              },
            ),
            TextFormField(
              maxLines: 2,
              decoration: const InputDecoration(hintText: 'Book title'),
              validator: (value) => value!.isEmpty ? 'Enter book title' : null,
              onChanged: (val) {
                setState(() {
                  title = val;
                });
              },
            ),
            TextFormField(
              maxLines: 2,
              decoration: const InputDecoration(hintText: 'Book year'),
              validator: (value) => value!.isEmpty ? 'Enter book year' : null,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                year = val;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  widget.postBookCubit.postBooks(
                    BookItemDTO(
                      author: author,
                      title: title,
                      year: int.parse(year),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:good_reads_app/form/cubit/post_book_cubit.dart';

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
  final _formkey = GlobalKey<FormState>();
  // Text fields
  String author = '';
  String title = '';
  String year = '';

  @override
  Widget build(BuildContext context) {
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
                    author: author,
                    title: title,
                    year: year,
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

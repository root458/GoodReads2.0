import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_reads_app/counter/cubit/get_books_cubit.dart';
import 'package:good_reads_app/models/_index.dart';

class ItemListingPage extends StatefulWidget {
  const ItemListingPage({Key? key}) : super(key: key);

  @override
  State<ItemListingPage> createState() => _ItemListingPageState();
}

class _ItemListingPageState extends State<ItemListingPage> {
  @override
  void initState() {
    super.initState();

    context.read<GetBooksCubit>().getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form');
        },
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: const Text('Welcome'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<GetBooksCubit, GetBooksState>(
        builder: (BuildContext context, GetBooksState state) {
          return state.when(
            initial: () => const Center(child: Text('Welcome')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (List<BookItem> books) => books.isEmpty
                ? const Center(child: Text('Welcome'))
                : ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(books[index].title),
                      subtitle: Text(books[index].author),
                    ),
                  ),
            error: (error) => Center(child: Text(error)),
          );
        },
      ),
    );
  }
}

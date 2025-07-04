import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riddhi_task/blocs/bookmark/bookmark_bloc.dart';
import 'package:riddhi_task/models/post_model.dart';
import 'package:riddhi_task/services/api_services.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;
  final String userName;

  const UserDetailScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<List<PostModel>> _posts;

  final Color mintLight = const Color(0xFFE0F7F4);
  final Color mint = const Color(0xFFB2DFDB);
  final Color mintDark = const Color(0xFF80CBC4);

  @override
  void initState() {
    super.initState();
    _posts = ApiService.fetchPosts(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mintLight,
      appBar: AppBar(
        title: Text(
          widget.userName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: mintDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: mintDark));
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Error loading posts'));
          }

          final posts = snapshot.data!;

          return BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (context, state) {
              final bookmarks = state is BookmarkLoaded ? state.bookmarks : [];

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  final isBookmarked = bookmarks.any((b) => b.id == post.id);

                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0.2,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.article_outlined,
                                color: Colors.teal,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  post.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline,
                                  color: isBookmarked ? mintDark : Colors.grey,
                                ),
                                onPressed: () {
                                  final bloc = context.read<BookmarkBloc>();
                                  isBookmarked
                                      ? bloc.removeBookmark(post.id)
                                      : bloc.addBookmark(post);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.notes_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  post.body,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

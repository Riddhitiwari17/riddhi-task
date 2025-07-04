import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riddhi_task/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<PostModel> bookmarks;
  BookmarkLoaded(this.bookmarks);
}

class BookmarkBloc extends Cubit<BookmarkState> {
  List<PostModel> _bookmarks = [];

  BookmarkBloc() : super(BookmarkInitial()) {
    loadBookmarks();
  }

  void loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('bookmarks');
    if (data != null) {
      _bookmarks = PostModel.decode(data);
    }
    emit(BookmarkLoaded(List.from(_bookmarks)));
  }

  void addBookmark(PostModel post) async {
    _bookmarks.add(post);
    await _save();
  }

  void removeBookmark(int id) async {
    _bookmarks.removeWhere((p) => p.id == id);
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookmarks', PostModel.encode(_bookmarks));
    emit(BookmarkLoaded(List.from(_bookmarks)));
  }
}

part of 'document_cubit.dart';

@immutable
sealed class DocumentState {}

final class DocumentInitial extends DocumentState {}

class ReadDocumentsLoading extends DocumentState {}

class ReadDocumentsSuccess extends DocumentState {}

class ReadDocumentsError extends DocumentState {
  final String error;
  ReadDocumentsError(this.error);
}

// add new document

class AddNewDocumentLoading extends DocumentState {}

class AddNewDocumentSuccess extends DocumentState {}

class AddNewDocumentError extends DocumentState {
  final String error;
  AddNewDocumentError(this.error);
}

// search in items

class SearchInItemsLoading extends DocumentState {}

class SearchInItemsSuccess extends DocumentState {}

class SearchInItemsError extends DocumentState {
  final String error;

  SearchInItemsError(this.error);
}

class AddNewItemToListSuccess extends DocumentState{}

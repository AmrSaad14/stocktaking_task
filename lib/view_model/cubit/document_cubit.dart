import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stocktaking_task/helpers/database_helper.dart';
import 'package:stocktaking_task/main.dart';
import 'package:stocktaking_task/model/item_model.dart';

part 'document_state.dart';

DocumentCubit documentCubit = DocumentCubit.get(navigatorKey.currentContext!);

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(DocumentInitial());

  static DocumentCubit get(context) => BlocProvider.of(context);

// read last item to display the next item number in new document screen
  TextEditingController newDocumentNumberController = TextEditingController();
  void readLastItemFromDatabase() async {
    emit(ReadDocumentsLoading());
    List<ItemModel> items = [];
    try {
      final List<Map<String, dynamic>> result =
          await DBHelper.query(tableName: 'items');
      if (result.isNotEmpty) {
        items.addAll(result.map((e) => ItemModel.fromJson(e)).toList());
        //get the last number and increase it 1
        newDocumentNumberController.text =
            (int.parse(items.last.id ?? '0') + 1).toString();
      } else {
        newDocumentNumberController.text = '1';
      }
      quantityController.text = '1';
      emit(ReadDocumentsSuccess());
    } catch (error) {
      debugPrint(error.toString());
      emit(ReadDocumentsError(error.toString()));
    }
  }

  TextEditingController barcodeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  void addNewDocument() async {
    emit(AddNewDocumentLoading());
    try {
      ItemModel model = ItemModel(
        newDocumentNumberController.text,
        barcodeController.text,
        500,
        int.parse(quantityController.text),
        DateTime.now().toString(),
        DateTime.now().toString(),
      );

      await DBHelper.insert(model: model, tableName: 'items');

      barcodeController.clear();
      quantityController.text = '1';
      searchItems.clear();

      emit(AddNewDocumentSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(AddNewDocumentError(e.toString()));
    }
  }

  List<ItemModel> searchItems = [];

  void searchInDatabse({required String searchText}) async {
    emit(SearchInItemsLoading());
    try {
      searchItems.clear();

      final List<Map<String, dynamic>> result =
          await DBHelper.search(searchKeywork: searchText);
      if (result.isNotEmpty) {
        searchItems.addAll(result.map((e) => ItemModel.fromJson(e)).toList());
      } else {
        debugPrint('items is empty');
      }
      emit(SearchInItemsSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(SearchInItemsError(e.toString()));
    }
  }

  void addItemToList() async {
    ItemModel model = ItemModel(
      newDocumentNumberController.text,
      barcodeController.text,
      500,
      int.parse(quantityController.text),
      DateTime.now().toString(),
      DateTime.now().toString(),
    );
    searchItems.add(model);
    emit(AddNewItemToListSuccess());
  }
}

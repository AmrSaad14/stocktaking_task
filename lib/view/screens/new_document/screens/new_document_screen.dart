import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocktaking_task/view_model/cubit/document_cubit.dart';

class NewDocumentScreen extends StatefulWidget {
  const NewDocumentScreen({super.key});

  @override
  State<NewDocumentScreen> createState() => _NewDocumentScreenState();
}

class _NewDocumentScreenState extends State<NewDocumentScreen> {
  @override
  void initState() {
    documentCubit.readLastItemFromDatabase();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DocumentCubit, DocumentState>(
        listener: (context, state) {
          if (state is AddNewDocumentSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Document No',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                            width: 50,
                            height: 30,
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  documentCubit.newDocumentNumberController,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Barcode',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Qty.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              controller: documentCubit.barcodeController,
                              onFieldSubmitted: (value) {
                                documentCubit.searchInDatabse(
                                    searchText: value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            )),
                        SizedBox(
                            width: 150,
                            height: 50,
                            child: TextFormField(
                              controller: documentCubit.quantityController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            documentCubit.addItemToList();
                          },
                          child: const Text('ADD'),
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 250,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2.0)),
                      child: ListView.builder(
                          itemCount: documentCubit.searchItems.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(documentCubit
                                          .searchItems[index].barcode ??
                                      ''),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(documentCubit.searchItems[index].quantity
                                          ?.toString() ??
                                      ''),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            documentCubit.addNewDocument();
                          },
                          child: const Text('Save'),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

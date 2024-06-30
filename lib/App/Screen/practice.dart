import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptAcceptScreen extends StatefulWidget {
  const ReceiptAcceptScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptAcceptScreen> createState() => _ReceiptAcceptScreenState();
}

class _ReceiptAcceptScreenState extends State<ReceiptAcceptScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<DocumentSnapshot> _documentFuture;

  @override
  void initState() {
    super.initState();
    _documentFuture = _getDocument();
  }

  Future<DocumentSnapshot> _getDocument() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print(user!.uid);
      return await _firestore.collection('ReceiptDetails').doc(user.uid).get();
    } catch (e) {
      throw Exception('Error fetching document: $e');
    }
  }

  Future<void> _updateStatus(String documentId, String newStatus) async {
    try {
      await _firestore
          .collection('ReceiptDetails')
          .doc(documentId)
          .update({'Status': newStatus});
    } catch (e) {
      throw Exception('Error updating status: $e');
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Approve':
        return Colors.green;
      case 'Reject':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
            height: 800,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Receipt List"),
                  Row(
                    children: [
                      Expanded(flex: 20, child: Text("Receipt Id")),
                      Expanded(flex: 20, child: Text("Amount")),
                      Expanded(flex: 20, child: Text("Status")),
                      Expanded(flex: 20, child: Text("CreateTime")),
                      Expanded(flex: 20, child: Text("Action")),
                    ],
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: StreamBuilder(
                      stream:
                          _firestore.collection('ReceiptDetails').snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData) {
                          return Center(child: Text('No data found'));
                        }

                        final documents = snapshot.data!.docs.where((document) {
                          final status = document['Status'];
                          return status == 'Pending' || status == 'Reject';
                        }).toList();

                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final document = documents[index];
                            var date = document['created_at'].toDate();
                            var formattedDate = DateFormat.yMMMd().format(date);

                            return Row(
                              children: [
                                Expanded(
                                    flex: 20,
                                    child: Text("${document['ReceiptId']}")),
                                Expanded(
                                    flex: 20,
                                    child: Text("${document['TransferA']}")),
                                Expanded(
                                    flex: 20,
                                    child: Text(
                                      "${document['Status']}",
                                      style: TextStyle(
                                          color: _getStatusColor(
                                              document['Status'])),
                                    )),
                                Expanded(
                                    flex: 20, child: Text("$formattedDate")),
                                Expanded(
                                  flex: 20,
                                  child: DropdownButton<String>(
                                    value: document['Status'],
                                    items: <String>[
                                      'Pending',
                                      'Approve',
                                      'Reject'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: _getStatusColor(value)),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        _updateStatus(document.id, newValue);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
);
}
}
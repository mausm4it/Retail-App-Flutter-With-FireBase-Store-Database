import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';
import 'package:ratailapp/Widget/AppTextField.dart';
import 'package:ratailapp/Widget/SnackBar.dart';
import 'package:ratailapp/App/Screen/TransferScreen.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TransferDaimondImoScreen extends StatefulWidget {
  const TransferDaimondImoScreen({Key? key}) : super(key: key);

  @override
  State<TransferDaimondImoScreen> createState() =>
      _TransferDaimondImoScreenState();
}

class _TransferDaimondImoScreenState extends State<TransferDaimondImoScreen> {
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final user = FirebaseAuth.instance.currentUser;

  List<String> transferees = []; // List to hold transferees' phone numbers

  @override
  void initState() {
    super.initState();
    fetchTransferees(); // Fetch transferees when the screen initializes
  }

  Future<void> fetchTransferees() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Check').get();
      final List<String> phones = snapshot.docs
          .map((doc) => doc['mobile'] as String)
          .toList(); // Extract phone numbers from documents
      setState(() {
        transferees = phones;
      });
    } catch (e) {
      print('Error fetching transferees: $e');
    }
  }

  Future<void> updateProfile() async {
    try {
      await FirebaseFirestore.instance.collection('TransferDetails').add({
        'TransferDiamond': amountController.text,
        'TransferNumber': selectedTransferee,
        'created_at': FieldValue.serverTimestamp(),
        'user': user!.uid,
      });
      showSnackBarMessage(context, 'Transfer successful!');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TransferScreen()),
      );
    } catch (e) {
      print('Error updating profile: $e');
      showSnackBarMessage(context, 'Transfer failed. Try again.', true);
    }
  }

  String? selectedTransferee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Transfer Diamonds'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Card(
          elevation: 5,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Transfer Number"),
                  DropdownSearch<String>(
                    items: transferees,
                    selectedItem: selectedTransferee,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTransferee = newValue;
                      });
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: 'Select Number', // Placeholder text
                      ),
                    ),
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Diamond"),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(
                      hintText: 'Diamond',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Diamond';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // Handle onChanged
                    },
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 80,
                        child: AppElevatedButton(
                          Color: Colors.green,
                          onTap: () {
                            updateProfile();
                          },
                          child: Center(
                            child: Text(
                              "Confirm",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

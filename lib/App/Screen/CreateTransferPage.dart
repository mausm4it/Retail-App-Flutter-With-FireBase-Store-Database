import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';
import 'package:ratailapp/Widget/AppTextField.dart';
import 'package:ratailapp/Widget/SnackBar.dart';
import 'package:ratailapp/App/Screen/ReceiptPage.dart'; // Import the screen

class CreateTransferScreen extends StatefulWidget {
  const CreateTransferScreen({Key? key}) : super(key: key);

  @override
  State<CreateTransferScreen> createState() => _CreateTransferScreenState();
}

class _CreateTransferScreenState extends State<CreateTransferScreen> {
  final TextEditingController AmountETController = TextEditingController();
  final TextEditingController ReceiptIDETController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  String? currentDiamondValue;

  @override
  void initState() {
    super.initState();
    fetchCurrentDiamondValue();
  }

  Future<void> fetchCurrentDiamondValue() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Check')
          .doc(user!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          currentDiamondValue = snapshot['diamond'].toString();
        });
      } else {
        showSnackBarMessage(context, 'No diamond data found for this user');
      }
    } catch (e) {
      showSnackBarMessage(context, 'Failed to fetch diamond data: $e', true);
    }
  }

  Future<void> updateProfile() async {
    try {
      await FirebaseFirestore.instance.collection('ReceiptDetails').add({
        'TransferDiamond': AmountETController.text,
        'ReceiptNumber': ReceiptIDETController.text,
        'Status': 'Pending',
        'created_at': FieldValue.serverTimestamp(),
        'user': user!.uid,
      });
      showSnackBarMessage(
          context, 'Recharge Request successfully sent to Admin');

      // Navigate to ReceiptAcceptScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReceiptAcceptScreen()),
      );
    } catch (e) {
      print('Error signing up: $e');
      showSnackBarMessage(context, 'Recharge Request Failed! Try again', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Text("Recharge Diamond Request"),
                          trailing: Text(
                            "Current Diamond: ${currentDiamondValue ?? '0'}",
                          ),
                        ),
                        Divider(color: Colors.blueGrey),
                        Text("Receipt Number"),
                        SizedBox(height: 3),
                        AppTextFieldWidget(
                          controller: ReceiptIDETController,
                          validator: (value) {
                            if ((value?.isEmpty ?? true) &&
                                ((value?.length ?? 0) < 6)) {
                              return 'Enter receipt number more than 6 characters';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          hintText: 'Receipt Number',
                        ),
                        SizedBox(height: 3),
                        Text("Diamond"),
                        SizedBox(height: 3),
                        AppTextFieldWidget(
                          controller: AmountETController,
                          hintText: "Transfer Diamond",
                          validator: (value) {
                            if ((value?.isEmpty ?? true) &&
                                ((value?.length ?? 0) < 6)) {
                              return 'Enter a valid diamond amount';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 5),
                        AppElevatedButton(
                          Color: Colors.green,
                          onTap: updateProfile,
                          child: Center(
                            child: Text(
                              "Recharge",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

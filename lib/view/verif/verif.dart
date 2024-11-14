import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify/view/verif/controller.dart';

class Verif extends GetView<VerifController> {
  const Verif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    print('Ini saya');
                controller.login();
              }, child: Text('Verif it`s you', style: GoogleFonts.poppins(
                color: Colors.white,
              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF343130)
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

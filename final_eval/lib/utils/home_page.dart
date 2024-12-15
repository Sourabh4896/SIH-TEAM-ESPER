import 'package:flutter/material.dart';
import 'register_process_page.dart';  // Import the new registration process page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Animated Text with motion effect
            AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              duration: Duration(seconds: 1),
              child: Text("UIDAI Face Authentication"),
            ),

            SizedBox(height: 50),

            // Animated Button with Motion
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  // Navigate to the registration process page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterProcessPage()),
                  );
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

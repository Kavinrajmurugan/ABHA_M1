import 'package:abha_api/Aadhaar/aadhaar_login.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedOption = "Aadhaar Card";

  void _navigateToSelectedPage(String optionTitle) {
    if (optionTitle == "Aadhaar Card") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AadhaarLoginPage()),
      );
    } else if (optionTitle == "Driving License") {
      // Add Driving License page navigation here
    }
  }

  Widget _buildOptionCard(String optionTitle, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedOption = optionTitle;
          });
          _navigateToSelectedPage(optionTitle);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 80,
              ),
              const SizedBox(height: 10),
              Text(
                optionTitle,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Column(
            children: [
              Text('Create ABHA Number', style: TextStyle(fontSize: 20)),
              Text(
                  'Please choose one of the below option to start with the creation of your ABHA'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildOptionCard("Aadhaar Card", 'images/aadh.png'),
              _buildOptionCard("Driving License", 'images/driving.png'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Already have an ABHA number?'),
          InkWell(
            child: const Text('Login', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AadhaarLoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

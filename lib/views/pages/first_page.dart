import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/first_page_viewmodel.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _palindromeController.dispose();
    super.dispose();
  }

  void _showPalindromeResult() {
    // Check if palindrome field is empty
    if (_palindromeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Palindrome cannot be empty')),
      );
      return;
    }

    final viewModel = Provider.of<FirstPageViewModel>(context, listen: false);
    final text = _palindromeController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(viewModel.getPalindromeTitle(text)),
          // content: Text(viewModel.getPalindromeResult(text)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToSecondPage() {
    // Check if name field is empty
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty')),
      );
      return;
    }

    final viewModel = Provider.of<FirstPageViewModel>(context, listen: false);
    final name = _nameController.text.trim();

    viewModel.setUserName(name);
    Navigator.pushNamed(context, '/second', arguments: name);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirstPageViewModel>(
      builder: (context, value, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background@3x.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo or App Title
                    Image.asset(
                      'assets/images/ic_photo@2x.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 40),
            
                    // Name Input Field
                    TextField(
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
            
                    // Palindrome Input Field
                    TextField(
                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
                      controller: _palindromeController,
                      decoration: const InputDecoration(
                        hintText: 'Palindrome',
                        hintStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
            
                    // Check Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _showPalindromeResult,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Color(0xFF2B637B),
                        ),
                        child: const Text('CHECK',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    const SizedBox(height: 16),
            
                    // Next Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _navigateToSecondPage,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Color(0xFF2B637B),
                        ),
                        child: const Text('NEXT',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

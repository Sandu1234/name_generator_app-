// ignore_for_file: use_full_hex_values_for_flutter_colors, library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For copying to clipboard

void main() {
  runApp(const NameGeneratorApp());
}

class NameGeneratorApp extends StatelessWidget {
  const NameGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Name Generator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const NameGeneratorPage(),
    );
  }
}

class NameGeneratorPage extends StatefulWidget {
  const NameGeneratorPage({super.key});

  @override
  _NameGeneratorPageState createState() => _NameGeneratorPageState();
}

class _NameGeneratorPageState extends State<NameGeneratorPage> {
  String _generatedName = 'Press Generate to create a name';
  String _generatedUsername = 'Press Generate to create a username';
  String _generatedPassword = 'Press Generate to create a password';

  final List<String> _names = [
    'Alex',
    'Jordan',
    'Taylor',
    'Morgan',
    'Casey',
    'Riley',
    'Sam',
    'Jamie',
    'Quinn',
    'Avery',
    'Parker',
    'Drew',
  ];

  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<String> _pageTitles = [
    'Name Generator',
    'Username Generator',
    'Password Generator',
  ];

  void _generateName() {
    final random = Random();
    final randomIndex = random.nextInt(_names.length);
    setState(() {
      _generatedName = _names[randomIndex];
    });
  }

  void _generateUsername() {
    final random = Random();
    final randomIndex = random.nextInt(_names.length);
    final randomNumber =
        random.nextInt(1000); // Add a random number to the username
    setState(() {
      _generatedUsername = '${_names[randomIndex]}$randomNumber';
    });
  }

  void _generatePassword() {
    const length = 12;
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#\$%^&*';
    final random = Random();
    final password =
        List.generate(length, (index) => chars[random.nextInt(chars.length)])
            .join();
    setState(() {
      _generatedPassword = password;
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF90a955),
      appBar: AppBar(
        title: Text(_pageTitles[_currentPageIndex]),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          // Name Generator Page
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _generatedName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _generateName,
                    child: const Text('Generate Name'),
                  ),
                  ElevatedButton(
                    onPressed: () => _copyToClipboard(_generatedName),
                    child: const Text('Copy Name to Clipboard'),
                  ),
                ],
              ),
            ),
          ),
          // Username Generator Page
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _generatedUsername,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _generateUsername,
                    child: const Text('Generate Username'),
                  ),
                  ElevatedButton(
                    onPressed: () => _copyToClipboard(_generatedUsername),
                    child: const Text('Copy Username to Clipboard'),
                  ),
                ],
              ),
            ),
          ),
          // Password Generator Page
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _generatedPassword,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _generatePassword,
                    child: const Text('Generate Password'),
                  ),
                  ElevatedButton(
                    onPressed: () => _copyToClipboard(_generatedPassword),
                    child: const Text('Copy Password to Clipboard'),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Password Conditions:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '- Length: 12 characters\n'
                    '- Includes lowercase letters\n'
                    '- Includes uppercase letters\n'
                    '- Includes numbers\n'
                    '- Includes special characters (@#\$%^&*)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

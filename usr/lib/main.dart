import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Viewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MessageViewerPage(),
    );
  }
}

class MessageViewerPage extends StatefulWidget {
  const MessageViewerPage({super.key});

  @override
  State<MessageViewerPage> createState() => _MessageViewerPageState();
}

class _MessageViewerPageState extends State<MessageViewerPage> {
  final TextEditingController _phoneController = TextEditingController();
  List<String> _messages = [];
  bool _searched = false;

  // This is a mock database of messages.
  // In a real app, this data would come from a secure backend.
  final Map<String, List<String>> _mockMessages = {
    '1234567890': [
      'Hey, are you free for lunch tomorrow?',
      'Just a reminder about the meeting at 3 PM.',
      'Great job on the presentation!',
    ],
    '9876543210': [
      'Happy Birthday! 🎉',
      'Can you send me the report?',
      'Let\'s catch up soon.',
    ],
    '5551234567': [
      'Your package has been delivered.',
      'Don\'t forget to pick up groceries on your way home.',
    ],
  };

  void _findMessages() {
    final phoneNumber = _phoneController.text;
    setState(() {
      _messages = _mockMessages[phoneNumber] ?? [];
      _searched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Viewer'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Enter Phone Number',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _findMessages,
              child: const Text('Get Messages'),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Messages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: _searched
                  ? _messages.isNotEmpty
                      ? ListView.builder(
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                leading: const Icon(Icons.message),
                                title: Text(_messages[index]),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No messages found for this number.'),
                        )
                  : const Center(
                      child: Text('Enter a phone number to see messages.'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

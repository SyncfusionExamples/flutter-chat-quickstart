import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/chat.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: ChatWidget(),
    ),
  ));
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SfChat(
        messages: _messages,
        outgoingUser: '123-001',
        composer: const ChatComposer(),
        placeholderBuilder: (BuildContext context) => _buildPlaceholder(),
        actionButton: ChatActionButton(
          onPressed: (String newMessage) => _addNewMessage(newMessage),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.question_answer_outlined,
                size: 35, color: Color(0xFF433D8B)),
            Text(
              'Start a conversation!',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: const Color(0xFF433D8B)),
            ),
            const SizedBox(height: 10),
            const Text(
              'You haven\'t sent any messages yet.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _addNewMessage(String text) {
    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          time: DateTime.now(),
          author: const ChatAuthor(id: '123-001', name: 'John Doe'),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/chat.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: ChatScreen(),
    ),
  ));
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isTextEmpty = false;

  void _updateSentText() {
    setState(() {
      _isTextEmpty = _textController.text.trim().isNotEmpty;
    });
  }

  void _sendMessage() {
    final String text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: text,
          time: DateTime.now(),
          author: const ChatAuthor(id: 'user', name: 'John'),
        ));
      });
      _textController.clear();
      _focusNode.requestFocus();
    }
  }

  ChatComposer _buildChatComposer() {
    return ChatComposer.builder(
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            _buildMessageInputField(),
            if (_isTextEmpty) _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Expanded(
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type a message...',
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      height: 40,
      child: FloatingActionButton(
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF433D8B),
        onPressed: _sendMessage,
        child: const Icon(Icons.send, size: 20, color: Colors.white),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const Text('You haven\'t sent any messages yet.',
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateSentText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SfChat(
        messages: _messages,
        outgoingUser: 'user',
        composer: _buildChatComposer(),
        placeholderBuilder: (BuildContext context) => _buildPlaceholder(),
      ),
    );
  }

  @override
  void dispose() {
    _textController.removeListener(_updateSentText);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

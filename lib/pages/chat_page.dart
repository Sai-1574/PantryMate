import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:lastone/const.dart';

class ChatPage1 extends StatefulWidget {
  const ChatPage1({super.key});

  @override
  State<ChatPage1> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage1> {

  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY, 
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 5,
        ),
      ),
      enableLog: true,
    );




  final ChatUser _currentUser = ChatUser(id: '1',firstName: 'Soi',lastName: 'Soi');
  final ChatUser _gptChatUser = ChatUser(id: '2',firstName: 'Chat',lastName: 'GPT');

  List<ChatMessage> _messages = <ChatMessage>[];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(
          0, 
          166, 
          126, 
          1
        ),
        title: const Text(
          'Test',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DashChat(
        currentUser: _currentUser,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromRGBO(
            0,
            166, 
            126, 
            1,
          ),
          textColor: Colors.white,
        ),
      onSend: (ChatMessage m){
          getChatResponse(m);
      },
      messages: _messages,
      
    ),
    );
  }


  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
    });


    List<Map<String, dynamic>> _messagesHistory = _messages.reversed.map((m) {
    if (m.user == _currentUser) {
      return {'role': 'user', 'content': m.text};
    } else {
      return {'role': 'assistant', 'content': m.text};
    }
  }).toList();

    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(), 
      messages: _messagesHistory,
      maxToken: 200,
    );

    final response = await _openAI.onChatCompletion(request:request);

    for(var element in response!.choices){
      if(element.message!=null){
        setState(() {
          _messages.insert(0, ChatMessage(user: _gptChatUser, createdAt: DateTime.now(),text: element.message!.content));
        });
      }
    }
  }
}
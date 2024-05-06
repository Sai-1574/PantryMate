


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 86, 118, 207),
//         title: const Text(
//           'PANTRY MATE',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//           ),
//         ),
//       ),
//       backgroundColor: Color.fromARGB(255, 178, 212, 228), // Change the background color
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _ingredientController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter an ingredient',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     addToPantry(_ingredientController.text);
//                     _ingredientController.clear();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text('Add to Pantry', 
//                   style: TextStyle(color: Colors.white),),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16.0),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: _buildPantryChips(),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 generateRecipe();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               child: const Text('Generate Recipe',style: TextStyle(color: Colors.white),),
//             ),
//             const SizedBox(height: 16.0),
//             if (_detailedRecipe.isNotEmpty)
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text(
//                         _detailedRecipe,
//                         style: const TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void addToPantry(String ingredient) {
//     setState(() {
//       _pantry.add(ingredient);
//     });
//   }

//   List<Widget> _buildPantryChips() {
//     List<Widget> chips = [];
//     for (int i = 0; i < _pantry.length; i++) {
//       chips.add(Chip(
//         label: Text(_pantry[i]),
//         onDeleted: () {
//           removeFromPantry(i);
//         },
//       ));
//     }
//     return chips;
//   }

//   void removeFromPantry(int index) {
//     setState(() {
//       _pantry.removeAt(index);
//     });
//   }

//   Future<void> generateRecipe() async {
//     if (_pantry.isNotEmpty) {
//       final request = ChatCompleteText(
//         model: GptTurbo0301ChatModel(),
//         messages: [
//           {'role': 'user', 'content': 'I have ${_pantry.join(', ')} in my pantry.'}
//         ],
//         maxToken: 200,
//       );

//       final response = await _openAI.onChatCompletion(request: request);

//       String detailedRecipe = '';
//       for (var element in response!.choices) {
//         if (element.message != null) {
//           detailedRecipe += element.message!.content + '\n';
//         }
//       }

//       setState(() {
//         _detailedRecipe = detailedRecipe;
//       });
//     } else {
//       setState(() {
//         _detailedRecipe = 'Your pantry is empty. Please add ingredients first.';
//       });
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:lastone/const.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class RecipeGeneratorPage extends StatefulWidget {
  const RecipeGeneratorPage({super.key});

  @override
  State<RecipeGeneratorPage> createState() => _RecipeGeneratorPageState();
}

class _RecipeGeneratorPageState extends State<RecipeGeneratorPage> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 5),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'Sai', lastName: 'Sai');
  final ChatUser _gptChatUser = ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');

  List<ChatMessage> _messages = <ChatMessage>[];
  List<String> _pantry = [];
  List<String> _shoppingList = [];

  TextEditingController _ingredientController = TextEditingController();

  String _detailedRecipe = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 86, 118, 207),
        title: const Text(
          'PANTRY MATE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 207, 238, 225), // Change the background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientController,
                    decoration: InputDecoration(
                      hintText: 'Enter an ingredient',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    addToPantry(_ingredientController.text);
                    _ingredientController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Add to Pantry', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _buildPantryChips(),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      generateRecipe();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Generate Recipe', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      createShoppingList();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Create Shopping List', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            if (_shoppingList.isNotEmpty)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shopping List:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _shoppingList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_shoppingList[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (_detailedRecipe.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _detailedRecipe,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void addToPantry(String ingredient) {
    setState(() {
      _pantry.add(ingredient);
    });
  }

  void createShoppingList() {
    setState(() {
      _shoppingList = List.from(_pantry);
    });
  }

  List<Widget> _buildPantryChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _pantry.length; i++) {
      chips.add(Chip(
        label: Text(_pantry[i]),
        onDeleted: () {
          removeFromPantry(i);
        },
      ));
    }
    return chips;
  }

  void removeFromPantry(int index) {
    setState(() {
      _pantry.removeAt(index);
    });
  }

  Future<void> generateRecipe() async {
    if (_pantry.isNotEmpty) {
      final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: [
          {'role': 'user', 'content': 'I have ${_pantry.join(', ')} in my pantry.'}
        ],
        maxToken: 200,
      );

      final response = await _openAI.onChatCompletion(request: request);

      String detailedRecipe = '';
      for (var element in response!.choices) {
        if (element.message != null) {
          detailedRecipe += element.message!.content + '\n';
        }
      }

      setState(() {
        _detailedRecipe = detailedRecipe;
      });

    } else {
      setState(() {
        _detailedRecipe = 'Your pantry is empty. Please add ingredients first.';
      });
    }
  }
}







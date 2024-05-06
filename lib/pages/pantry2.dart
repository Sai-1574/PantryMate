// import 'package:flutter/material.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:lastone/const.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:firebase_database/firebase_database.dart';

// class RecipeGeneratorPage extends StatefulWidget {
//   const RecipeGeneratorPage({super.key});

//   @override
//   State<RecipeGeneratorPage> createState() => _RecipeGeneratorPageState();
// }

// class _RecipeGeneratorPageState extends State<RecipeGeneratorPage> {
//   final _openAI = OpenAI.instance.build(
//     token: OPENAI_API_KEY,
//     baseOption: HttpSetup(
//       receiveTimeout: const Duration(seconds: 5),
//     ),
//     enableLog: true,
//   );

//   final ChatUser _currentUser = ChatUser(id: '1', firstName: 'Soi', lastName: 'Soi');
//   final ChatUser _gptChatUser = ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');

//   List<ChatMessage> _messages = <ChatMessage>[];
//   List<String> _pantry = [];

//   TextEditingController _ingredientController = TextEditingController();

//   String _detailedRecipe = '';

//   final DatabaseReference _recipeRef = FirebaseDatabase.instance.reference().child('recipes');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
//         title: const Text(
//           'Recipe Generator',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16.0),
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _ingredientController,
//                         decoration: InputDecoration(
//                           hintText: 'Enter an ingredient',
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         addToPantry(_ingredientController.text);
//                         _ingredientController.clear();
//                       },
//                       child: Text('Add to Pantry'),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 Wrap(
//                   spacing: 8.0,
//                   runSpacing: 8.0,
//                   children: _buildPantryChips(),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     generateRecipe();
//                   },
//                   child: Text('Generate Recipe'),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     saveRecipeToFirebase();
//                   },
//                   child: Text('Save Recipe'),
//                 ),
//                 SizedBox(height: 16.0),
//                 if (_detailedRecipe.isNotEmpty)
//                   Text(
//                     _detailedRecipe,
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//               ],
//             ),
//           ),
//         ],
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

//   void saveRecipeToFirebase() {
//     if (_detailedRecipe.isNotEmpty) {
//       _recipeRef.push().set({
//         'recipeText': _detailedRecipe,
//         'timestamp': DateTime.now().toIso8601String(),
//       }).then((_) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Recipe saved to Firebase'),
//           duration: Duration(seconds: 2),
//         ));
//       }).catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to save recipe: $error'),
//           duration: Duration(seconds: 2),
//         ));
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('No recipe to save'),
//         duration: Duration(seconds: 2),
//       ));
//     }
//   }
// }








// import 'package:flutter/material.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:lastone/const.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

// class RecipeGeneratorPage extends StatefulWidget {
//   const RecipeGeneratorPage({super.key});

//   @override
//   State<RecipeGeneratorPage> createState() => _RecipeGeneratorPageState();
// }

// class _RecipeGeneratorPageState extends State<RecipeGeneratorPage> {
//   final _openAI = OpenAI.instance.build(
//     token: OPENAI_API_KEY,
//     baseOption: HttpSetup(
//       receiveTimeout: const Duration(seconds: 5),
//     ),
//     enableLog: true,
//   );

//   final ChatUser _currentUser = ChatUser(id: '1', firstName: 'Sai', lastName: 'Sai');
//   final ChatUser _gptChatUser = ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');

//   List<ChatMessage> _messages = <ChatMessage>[];
//   List<String> _pantry = [];

//   TextEditingController _ingredientController = TextEditingController();

//   String _detailedRecipe = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
// //         title: const Text(
// //           'PANTRY MATE',
// //           style: TextStyle(
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView(
// //               padding: EdgeInsets.all(16.0),
// //               children: [
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: TextField(
// //                         controller: _ingredientController,
// //                         decoration: InputDecoration(
// //                           hintText: 'Enter an ingredient',
// //                         ),
// //                       ),
// //                     ),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         addToPantry(_ingredientController.text);
// //                         _ingredientController.clear();
// //                       },
// //                       child: Text('Add to Pantry'),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 Wrap(
// //                   spacing: 8.0,
// //                   runSpacing: 8.0,
// //                   children: _buildPantryChips(),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     generateRecipe();
// //                   },
// //                   child: Text('Generate Recipe'),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 if (_detailedRecipe.isNotEmpty)
// //                   Text(
// //                     _detailedRecipe,
// //                     style: TextStyle(fontSize: 16.0),
// //                   ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void addToPantry(String ingredient) {
// //     setState(() {
// //       _pantry.add(ingredient);
// //     });
// //   }

// //   List<Widget> _buildPantryChips() {
// //     List<Widget> chips = [];
// //     for (int i = 0; i < _pantry.length; i++) {
// //       chips.add(Chip(
// //         label: Text(_pantry[i]),
// //         onDeleted: () {
// //           removeFromPantry(i);
// //         },
// //       ));
// //     }
// //     return chips;
// //   }

// //   void removeFromPantry(int index) {
// //     setState(() {
// //       _pantry.removeAt(index);
// //     });
// //   }

// //   Future<void> generateRecipe() async {
// //     if (_pantry.isNotEmpty) {
// //       final request = ChatCompleteText(
// //         model: GptTurbo0301ChatModel(),
// //         messages: [
// //           {'role': 'user', 'content': 'I have ${_pantry.join(', ')} in my pantry.'}
// //         ],
// //         maxToken: 200,
// //       );

// //       final response = await _openAI.onChatCompletion(request: request);

// //       String detailedRecipe = '';
// //       for (var element in response!.choices) {
// //         if (element.message != null) {
// //           detailedRecipe += element.message!.content + '\n';
// //         }
// //       }

// //       setState(() {
// //         _detailedRecipe = detailedRecipe;
// //       });
// //     } else {
// //       setState(() {
// //         _detailedRecipe = 'Your pantry is empty. Please add ingredients first.';
// //       });
// //     }
// //   }
// // }

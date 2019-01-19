import 'package:flutter/material.dart';

import 'package:sentence/model/sentence.dart';
import 'package:sentence/pages/home.dart';
import 'package:sentence/pages/sentences.dart';

class FavoritesPage extends StatefulWidget {
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = HomePageState.favoriteSentences.map(
      (Sentence favoriteNames) {
        return ListTile(
          title: Text(
            favoriteNames.text,
            //style: _biggerFont,
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return ListView(
        children: divided,
        //children: <Widget>[Text("data")],
    );
  }

}

// import 'package:flutter/material.dart';
// import 'package:sentence/data/db_helper.dart';
// import 'package:sentence/model/sentence.dart';

// class FavoritesPage extends StatefulWidget {
//   @override
//   _FavoritesPageState createState() => _FavoritesPageState();
// }

// class _FavoritesPageState extends State<FavoritesPage> {
//   final controllerName = TextEditingController();
//   final controllerPhone = TextEditingController();
//   var dbHelper = DBHelper();

//   /// Creates Controller for update name and phone
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: FutureBuilder<List<Sentence>>(
//         future: dbHelper.getSentences(),
//         builder: (context, contacts) {
//           if (contacts.data != null && contacts.hasData) {
//             return _buildListView(contacts);
//           }
//           return _buildLoading();
//         },
//       ),
//     );
//   }

//   /// While loading
//   Widget _buildLoading() {
//     return Container(
//       alignment: AlignmentDirectional.center,
//       child: CircularProgressIndicator(),
//     );
//   }

//   Widget _buildListView(var snapshot) {
//     return ListView.builder(
//       itemCount: snapshot.data.length,
//       itemBuilder: (context, index) => Row(
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.only(bottom: 8),
//                       child: Text(
//                         snapshot.data[index].text,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       snapshot.data[index].regions,
//                       style: TextStyle(
//                         color: Colors.grey[500],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => {},
//                 child: Icon(
//                   Icons.update,
//                   color: Colors.red,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => {},
//                 child: Icon(
//                   Icons.delete,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//   }
// }

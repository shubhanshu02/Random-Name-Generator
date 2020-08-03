import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "Startup Name Generator",
      home: RandomWords(),
    );
  }
}



class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: buildSuggestions(),
    );
  }
  Widget buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
      
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  Widget _buildRow(WordPair pair) {
    final already_saved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.first + " " + pair.second,
        style: _biggerFont,
      ),
      trailing: Icon(
        already_saved? Icons.favorite : Icons.favorite_border,
        color: already_saved? Colors.red : null,
      ),
      onTap: () => {
        setState(() {
          already_saved ? _saved.remove(pair) : _saved.add(pair);
        })
      } ,
    );
  }
}
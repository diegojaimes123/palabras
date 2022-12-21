import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerfont = const TextStyle(fontSize: 18);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de palabras'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushsaved,
            tooltip: 'Palbras selecionadas',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadysaved = _saved.contains(_suggestions[index]);
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerfont ,
            ),
            trailing: Icon(
              alreadysaved ? Icons.favorite : Icons.favorite_border,
              color: alreadysaved ? Colors.red :null ,
              semanticLabel: alreadysaved ? 'remove from saved' : 'save',
            ),

            onTap: () {
              setState(() {
                if (alreadysaved) {
                  _saved.remove(_suggestions[index]);
                }
                else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {},),
            IconButton(icon: const Icon(Icons.circle_outlined), onPressed: () {},),
            IconButton(icon: const Icon(Icons.crop_square_sharp), onPressed: () {},),
          ],
        ),
      ),
    );
  }
  void _pushsaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerfont,
                ),
              );
            },

          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];
          return Scaffold(
            appBar: AppBar(
              title: const Text('palbras selecionadas'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
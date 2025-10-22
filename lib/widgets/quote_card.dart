import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteCard({super.key, required this.quote, required this.author});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[100],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              '"$quote"',
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          subtitle: Text(
            "- $author",
          ),
        ),
      ),
    );
  }
}

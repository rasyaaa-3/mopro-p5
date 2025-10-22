import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mopro_p5/widgets/quote_card.dart';
import 'package:mopro_p5/pages/more_quotes.dart';
import 'package:http/http.dart' as http;
import 'package:mopro_p5/data/quote.dart';

class TodayQuote extends StatefulWidget {
  const TodayQuote({super.key});

  @override
  State<TodayQuote> createState() => _TodayQuoteState();
}

class _TodayQuoteState extends State<TodayQuote> {
  // Isi Logic 1
  late Future<Quote> quote;

  Future<Quote> fetchRandomQuote() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/quotes/random')
    );

    if (response.statusCode == 200) {
      return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Gagal memuat quotes");
    }
  }

  @override
  void initState() {
    super.initState();
    quote = fetchRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Quotes App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Quote",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // Isi Logic 2
                    setState(() {
                      quote = fetchRandomQuote();
                    });
                  },
                  label: Text("Refresh"),
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future: quote,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return QuoteCard(quote: snapshot.data!.quote, author: snapshot.data!.author);
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MoreQuotes())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                foregroundColor: Colors.white,
              ),
              child: Text("More Quotes"),
            ),
          ],
        ),
      ),
    );
  }
}

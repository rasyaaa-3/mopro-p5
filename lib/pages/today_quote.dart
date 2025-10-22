import 'package:flutter/material.dart';
import 'package:mopro_p5/widgets/quote_card.dart';

class TodayQuote extends StatefulWidget {
  const TodayQuote({super.key});

  @override
  State<TodayQuote> createState() => _TodayQuoteState();
}

class _TodayQuoteState extends State<TodayQuote> {
  // Isi Logic 1

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
                  },
                  label: Text("Refresh"),
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            SizedBox(height: 10),
            QuoteCard(quote: "Isi Quote", author: "Anonymous"),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
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

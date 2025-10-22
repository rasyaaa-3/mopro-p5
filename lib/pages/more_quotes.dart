import 'package:flutter/material.dart';
import 'package:mopro_p5/widgets/quote_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mopro_p5/data/quote.dart';

class MoreQuotes extends StatefulWidget {
  const MoreQuotes({super.key});

  @override
  State<MoreQuotes> createState() => _MoreQuotesState();
}

class _MoreQuotesState extends State<MoreQuotes> {
  // Isi Logic 1
  int limit = 10;
  int pagination = 1;
  late Future<List<Quote>> quotes;

  Future<List<Quote>> fetchQuotes() async {
    final response = await http.get(
      Uri.https('dummyjson.com', '/quotes', {
        'limit': '$limit',
        'skip': '${limit * pagination}',
      })
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['quotes'] as List<dynamic>;

      return data.map((quote) => Quote.fromJson(quote)).toList();
    } else {
      throw Exception("Gagal memuat quotes");
    }
  }

  @override
  void initState() {
    super.initState();
    quotes = fetchQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "More Quotes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            FutureBuilder(
              future: quotes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SliverList.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return QuoteCard(quote: snapshot.data![index].quote, author: snapshot.data![index].author);
                    },
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Text(
                      '${snapshot.error}\n${snapshot.stackTrace}',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator())
                );
              },
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: pagination > 1 ? () {
                        // Isi Logic 2
                        setState(() {
                          pagination--;
                          quotes = fetchQuotes();
                        });
                      } : null,
                      label: Text("Previous"),
                      icon: Icon(Icons.chevron_left),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Isi Logic 3
                        setState(() {
                          pagination++;
                          quotes = fetchQuotes();
                        });
                      },
                      label: Text("Next"),
                      icon: Icon(Icons.chevron_right),
                      iconAlignment: IconAlignment.end,
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

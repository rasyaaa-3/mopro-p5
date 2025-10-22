import 'package:flutter/material.dart';

class MoreQuotes extends StatefulWidget {
  const MoreQuotes({super.key});

  @override
  State<MoreQuotes> createState() => _MoreQuotesState();
}

class _MoreQuotesState extends State<MoreQuotes> {
  // Isi Logic 1

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
            SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Isi Logic 2
                      },
                      label: Text("Previous"),
                      icon: Icon(Icons.chevron_left),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Isi Logic 3
                      },
                      label: Text("Next"),
                      icon: Icon(Icons.chevron_right),
                      iconAlignment: IconAlignment.end,
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

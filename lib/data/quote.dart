class Quote {
  late final int id;
  late final String quote;
  late final String author;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  Quote.fromJson(Map<String, dynamic> data) {
    id = data['id'] as int;
    quote = data['quote'] as String;
    author = data['author'] as String;
  }
}

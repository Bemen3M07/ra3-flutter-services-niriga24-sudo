class Joke {
  final int id;
  final String setup;
  final String punchline;

  const Joke({
    required this.id,
    required this.setup,
    required this.punchline,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    final setup = (json['setup'] ?? json['question'] ?? '').toString().trim();
    final punchline =
        (json['punchline'] ?? json['answer'] ?? json['joke'] ?? '')
            .toString()
            .trim();

    return Joke(
      id: json['id'] as int? ?? 0,
      setup: setup,
      punchline: punchline,
    );
  }
}
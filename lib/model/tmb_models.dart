class TmbLine {
  final String code;
  final String name;

  const TmbLine({required this.code, required this.name});

  factory TmbLine.fromJson(Map<String, dynamic> json) {
    final code = (json['code'] ?? json['line'] ?? json['id'] ?? '').toString();
    final name =
        (json['name'] ?? json['line_name'] ?? json['description'] ?? code)
            .toString();
    return TmbLine(code: code, name: name);
  }
}

class TmbStop {
  final String code;
  final String name;

  const TmbStop({required this.code, required this.name});

  factory TmbStop.fromJson(Map<String, dynamic> json) {
    final code =
        (json['code'] ?? json['stop_code'] ?? json['id'] ?? '').toString();
    final name = (json['name'] ?? json['stop_name'] ?? json['description'] ?? code)
        .toString();
    return TmbStop(code: code, name: name);
  }
}

class TmbArrival {
  final String line;
  final String destination;
  final String minutes;

  const TmbArrival({
    required this.line,
    required this.destination,
    required this.minutes,
  });

  factory TmbArrival.fromJson(Map<String, dynamic> json) {
    final line = (json['line'] ?? json['route'] ?? json['linia'] ?? '-')
        .toString();
    final destination =
        (json['destination'] ?? json['desti'] ?? json['headsign'] ?? '-')
            .toString();
    final minutes =
        (json['minutes'] ?? json['time_in_min'] ?? json['t-in-min'] ?? '?')
            .toString();

    return TmbArrival(
      line: line,
      destination: destination,
      minutes: minutes,
    );
  }
}
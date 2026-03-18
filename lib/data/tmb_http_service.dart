import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/tmb_models.dart';
import '../utils/const_app.dart';

class TmbHttpService {
  Future<List<TmbLine>> getBusLines() async {
    final fallbackEndpoints = tmbBusLinesEndpointFallbacks
        .split('|')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    if (!fallbackEndpoints.contains(tmbBusLinesEndpoint)) {
      fallbackEndpoints.insert(0, tmbBusLinesEndpoint);
    }

    final jsonList = await _getListFromEndpointCandidates(fallbackEndpoints);
    return jsonList
        .map((item) => TmbLine.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<TmbStop>> getStops() async {
    final jsonList = await _getListFromEndpoint(tmbBusStopsEndpoint);
    return jsonList
        .map((item) => TmbStop.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<TmbArrival>> getArrivalsByStopCode(String stopCode) async {
    final endpoint = tmbStopArrivalsEndpoint.replaceAll('{stopCode}', stopCode);
    final jsonList = await _getListFromEndpoint(endpoint);
    return jsonList
        .map((item) => TmbArrival.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<dynamic>> _getListFromEndpoint(String endpoint) async {
    if (tmbAppId.isEmpty || tmbAppKey.isEmpty) {
      throw Exception(messageMissingTmbCredentials);
    }

    final uri = Uri.parse('$tmbBaseUrl$endpoint').replace(
      queryParameters: {
        'app_id': tmbAppId,
        'app_key': tmbAppKey,
      },
    );

    final response = await http.get(
      uri,
      headers: {'accept': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception(
        'Error API TMB ${response.statusCode} | URL: $uri | Body: ${_shortBody(response.body)}',
      );
    }

    final decoded = json.decode(utf8.decode(response.bodyBytes));
    final list = _extractList(decoded);
    if (list == null) {
      throw Exception(
        '$messageTmbUnexpectedResponse | URL: $uri | Body: ${_shortBody(response.body)}',
      );
    }

    return list;
  }

  Future<List<dynamic>> _getListFromEndpointCandidates(
    List<String> endpoints,
  ) async {
    final errors = <String>[];

    for (final endpoint in endpoints) {
      try {
        return await _getListFromEndpoint(endpoint);
      } catch (e) {
        errors.add(e.toString());
      }
    }

    throw Exception(
      'Cap endpoint de linies ha funcionat. Errors: ${errors.join(' || ')}',
    );
  }

  String _shortBody(String body) {
    final trimmed = body.replaceAll('\n', ' ').replaceAll('\r', ' ').trim();
    if (trimmed.length <= 220) {
      return trimmed;
    }
    return '${trimmed.substring(0, 220)}...';
  }

  List<dynamic>? _extractList(dynamic decoded) {
    if (decoded is List<dynamic>) {
      return decoded;
    }

    if (decoded is Map<String, dynamic>) {
      const candidates = [
        'data',
        'results',
        'features',
        'items',
        'ibus',
      ];

      for (final key in candidates) {
        final value = decoded[key];
        if (value is List<dynamic>) {
          return value;
        }
        if (value is Map<String, dynamic>) {
          final nested = _extractList(value);
          if (nested != null) {
            return nested;
          }
        }
      }

      for (final value in decoded.values) {
        if (value is List<dynamic>) {
          return value;
        }
        if (value is Map<String, dynamic>) {
          final nested = _extractList(value);
          if (nested != null) {
            return nested;
          }
        }
      }
    }

    return null;
  }
}
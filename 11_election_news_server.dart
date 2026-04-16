import 'dart:convert';
import 'dart:io';

void main() async {
  final cache = <String, Map<String, dynamic>>{};
  final subscribers = <String>{'general'};
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);

  print('Election news server running on http://localhost:8080');

  await for (final request in server) {
    final path = request.uri.path;
    request.response.headers.contentType = ContentType.json;

    if (path == '/subscribe' && request.method == 'POST') {
      final body = await utf8.decoder.bind(request).join();
      final data = jsonDecode(body) as Map<String, dynamic>;
      subscribers.add('${data['userId']}');
      request.response.write(jsonEncode({'status': 'subscribed'}));
    } else if (path == '/news') {
      final constituency =
          request.uri.queryParameters['constituency'] ?? 'general';
      final cached = cache[constituency];
      if (cached != null &&
          DateTime.now().difference(DateTime.parse(cached['timestamp'] as String)) <
              const Duration(seconds: 30)) {
        request.response.write(jsonEncode({
          'source': 'cache',
          'subscribers': subscribers.length,
          'data': cached['data'],
        }));
      } else {
        final data = {
          'headline': 'Live update for $constituency',
          'items': [
            'Polling percentage updated',
            'Candidate roadshow announced',
            'Counting center security increased',
          ],
        };
        cache[constituency] = {
          'timestamp': DateTime.now().toIso8601String(),
          'data': data,
        };
        request.response.write(jsonEncode({
          'source': 'fresh',
          'subscribers': subscribers.length,
          'data': data,
          'note':
              'Use nginx or a cloud load balancer in front of multiple Dart instances for real load balancing.',
        }));
      }
    } else if (path == '/push') {
      request.response.write(jsonEncode({
        'status': 'notification sent',
        'subscribers': subscribers.toList(),
      }));
    } else {
      request.response.statusCode = 404;
      request.response.write(jsonEncode({'error': 'Route not found'}));
    }

    await request.response.close();
  }
}

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.delete => _deleteUser(id),
    HttpMethod.put => _updateUser(context, id),
    _ => Future.value(Response(body: 'Not Implemented'))
  };
}

Future<Response> _updateUser(RequestContext context, String id) async {
  return Response.json(
    body: {
      'message': 'User Is Updated',
    },
  );
}

Future<Response> _deleteUser(String id) async {
  return Response.json(
    body: {
      'message': 'User with id:$id is Deleted',
    },
  );
}

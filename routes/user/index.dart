import 'package:dart_frog/dart_frog.dart';
import 'package:orm/generator_helper.dart';
import 'package:orm/orm.dart';

import '../../prisma/generated_dart_client/client.dart';
import '../../prisma/generated_dart_client/prisma.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _getUsers(context),
    HttpMethod.post => _createUser(context),
    _ => Future.value(Response(body: 'Not Implemented'))
  };
}

Future<Response> _getUsers(RequestContext context) async {
  final prisma = context.read<PrismaClient>();
  final users = (await prisma.user.findMany()).toList();
  return Future.value(Response.json(
    body: users,
  ));
}

Future<Response> _createUser(RequestContext context) async {
  final json = (await context.request.json()) as Map<String, dynamic>;
  final name = json['name'] as String;
  final email = json['email'] as String;
  final prisma = context.read<PrismaClient>();
  final user = await prisma.user.create(
      data: PrismaUnion.$1(
          UserCreateInput(email: email, name: PrismaUnion.$1(name))));
  return Response.json(
    body: {
      'message': 'Saved',
      'user': user,
    },
  );
}

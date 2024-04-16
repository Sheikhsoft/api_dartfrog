import 'package:dart_frog/dart_frog.dart';

import '../prisma/generated_dart_client/client.dart';

final _prisma = PrismaClient();

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(_provideDb());
}

Middleware _provideDb() {
  return provider<PrismaClient>((context) => _prisma);
}

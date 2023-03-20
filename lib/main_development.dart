import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inapps_picasso/gen/assets.gen.dart';
import 'package:inapps_picasso/start.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.env.envDevelopment);

  await start();
}

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class GravatarConfig {
  static Duration _stalePeriod = const Duration(days: 7);
  static String host = 'www.gravatar.com';

  static void init({
    required Duration cachePeriod,
  }) {
    _stalePeriod = cachePeriod;
  }
}

class GravatarCacheManager {
  static const key = 'gravatar_cache_custom_key';

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: GravatarConfig._stalePeriod,
    ),
  );
}

import 'dart:async';

import '../config/gravatar_api.dart';
import '../config/gravatar_api_option.dart';

mixin GravatarUrlSourceMixin {
  String urlKey(String email) => 'url:$email';

  Future<Uri?> getUrl(
    String email, {
    GravatarOptions gravatarOptions = const GravatarOptions(),
  }) async {
    return GravatarApi(email).imageUri(options: gravatarOptions);
  }
}

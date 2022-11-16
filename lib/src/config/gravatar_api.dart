import '../tools/tools.dart';

import 'gravatar_api_option.dart';
import 'gravatar_config.dart';

/// Gravatar image documentation:
///
/// https://en.gravatar.com/site/implement/images/
///

class GravatarApi {
  GravatarApi(String email)
      : assert(email.isNotEmpty && ToolsValidation.isEmailValid(email.trim())),
        _email = email.trim().toLowerCase();

  final String _email;

  final String _imageSize = 's';
  final String _imageRating = 'r';
  final String _imageDefault = 'd';

  Uri imageUri({
    GravatarOptions options = const GravatarOptions(),
  }) {
    final emailHash = ToolsCrypto.toMD5(_email);
    final uri = Uri.https(GravatarConfig.host, '/avatar/$emailHash', {
      _imageSize: options.size,
      _imageRating: options.rating,
      _imageDefault: options.asDefault,
    });

    return uri;
  }
}

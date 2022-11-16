class GravatarOptions {
  const GravatarOptions({
    this.imageSize = 80,
    this.avatarRating = 'r',
    this.defaultImage = '404',
  });

  final int imageSize;
  final String avatarRating;
  final String defaultImage;

  String get size => imageSize.toString();

  String get rating => avatarRating;

  String get asDefault => defaultImage;
}

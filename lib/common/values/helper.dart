class Helper {
  Helper._();

  static bool isEmpty(dynamic data) {
    if (data == null) return true;

    if (data is String || data is Map || data is List) {
      return data.isEmpty;
    }

    return false;
  }
}

enum HttpMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
  options,
  trace,
}

extension HttpMethodExtension on HttpMethod {
  String get value {
    return toString().split('.').last.toUpperCase();
  }
}

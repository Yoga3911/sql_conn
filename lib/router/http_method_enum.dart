enum HttpMethod {
  get("GET"),
  post("POST"),
  put("PUT"),
  delete("DELETE"),
  patch("PATCH");

  final String name;
  const HttpMethod(this.name);
}

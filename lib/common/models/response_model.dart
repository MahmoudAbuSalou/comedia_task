class Response {
  dynamic body;
  String? bodyString;
  Request? request;

  int? statusCode;
  String? statusText;

  Response({
    this.body,
    this.bodyString,
    this.request,

    this.statusCode,
    this.statusText,
  });


  Response.fromDioResponse( dioResponse) {
    body = dioResponse.data;
    bodyString = dioResponse.toString(); // DioResponse.toString() gives string representation
    request = Request(
      headers: dioResponse.requestOptions.headers,
      method: dioResponse.requestOptions.method,
      url: dioResponse.requestOptions.uri,
    );

    statusCode = dioResponse.statusCode;
    statusText = dioResponse.statusMessage;
  }
}
// Custom Request class
class Request {
  final Map<String, dynamic> headers; // Changed to dynamic for flexibility
  final String method;
  final Uri url;

  Request({required this.headers, required this.method, required this.url});
}
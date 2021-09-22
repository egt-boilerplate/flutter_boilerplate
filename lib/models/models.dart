class BaseResponse<T> {
  num status;
  T data;
  String? message;
  num? errCode;
  String? errMessage;
  BaseResponse({
    required this.status,
    required this.data,
    this.message,
    this.errCode,
    this.errMessage,
  });
}

class CommonListResponse<T> {
  int total;
  List<T> items;
  CommonListResponse({required this.total, required this.items});
}

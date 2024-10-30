class AppException {
  final String message;

  const AppException({required this.message});
}

class CustomException extends AppException {
  const CustomException({String? message})
      : super(message: message ?? 'Something went wrong');
}

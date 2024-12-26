import 'package:logging/logging.dart';

class MyLogger {
  // Trường lưu trữ đối tượng Logger
  final Logger logger;

  // Constructor nhận tên logger từ bên ngoài và khởi tạo đối tượng Logger
  MyLogger(String loggerName) : logger = Logger(loggerName) {
    // Bật hierarchical logging
    Logger.root.level = Level.ALL; // Cấu hình mức độ log cho root logger
    Logger.root.onRecord.listen((record) {
      // In log ra console
      print(
          '${record.loggerName}: ${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  // Phương thức để log thông tin (log level là Info)
  void logInfo(String message) {
    logger.info(message);
  }

  // Phương thức để log cảnh báo (log level là Warning)
  void logWarning(String message) {
    logger.warning(message);
  }

  // Phương thức để log lỗi (log level là SEVERE)
  void logError(String message) {
    logger.severe(message);
  }
}

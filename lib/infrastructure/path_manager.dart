import 'dart:io';
import 'package:path/path.dart' as path;

mixin PathManager {
  String getCurrentDirectoryPath();
  String getDownloadsPath();
}

class SystemPathManager implements PathManager {
  @override
  String getCurrentDirectoryPath() => Directory.current.path;

  @override
  String getDownloadsPath() {
    var home = _getHomePath();
    return path.join(home, 'Downloads');
  }

  String _getHomePath() {
    var envVars = Platform.environment;
    if (Platform.isMacOS) {
      return envVars['HOME'];
    } else if (Platform.isLinux) {
      return envVars['HOME'];
    } else if (Platform.isWindows) {
      return envVars['UserProfile'];
    } else {
      throw Exception('Unsupported Platform for generation');
    }
  }
}

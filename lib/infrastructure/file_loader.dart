import 'dart:io';

mixin FileLoader {
  Future<String> loadFile(String path);
}

class SystemFileLoader implements FileLoader {
  @override
  Future<String> loadFile(String path) async {
    return File(path).readAsString();
  }
}

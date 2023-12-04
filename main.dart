import 'dart:async';
import 'dart:io';
import 'dart:convert';

const String inputFile = "input.txt";

void main() async {
  await for (var l in openInput()) {
    print(l);
  }
}

Stream<String> openInput() {
  final file = File(inputFile);

  Stream<String> lines = file.openRead()
    .transform(utf8.decoder)       // Decode bytes to UTF-8.
    .transform(LineSplitter());    // Convert stream to individual lines.

  return lines;
}

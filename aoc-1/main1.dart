import 'dart:async';
import 'dart:io';
import 'dart:convert';

const String inputFile = "input.txt";

void main() async {
  var count = 0;
  var total = 0;

  await for (var l in openInput()) {
    // print(l);

    var firstNum = l.indexOf(RegExp(r'[0-9]'));
    var lastNum = l.lastIndexOf(RegExp(r'[0-9]'));

    var combined = "${l[firstNum]}${l[lastNum]}";

    print("${count++} $combined");

    total += int.parse(combined);
  }

  print("Total: $total");
}

Stream<String> openInput() {
  final file = File(inputFile);

  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  return lines;
}

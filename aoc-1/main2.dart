import 'dart:async';
import 'dart:io';
import 'dart:convert';

const String inputFile = "input.txt";

const Map<String, int> numberStrings = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
};

void main() async {
  var count = 0;
  var total = 0;

  await for (var l in openInput()) {
    // print(l);

    var firstNum = findFirstNumber(l);
    var lastNum = findLastNumber(l);

    var combined = "$firstNum$lastNum";

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

int findFirstNumber(String line) {
  var bestIndex = line.length;
  var firstNumber = 0;

  for (var s in numberStrings.keys) {
    var sIdx = line.indexOf(s);
    if (sIdx != -1 && sIdx <= bestIndex) {
      bestIndex = sIdx;
      firstNumber = numberStrings[s]!;
    }
  }

  var rIdx = line.indexOf(RegExp(r'[0-9]'));
  if (rIdx != -1 && rIdx <= bestIndex) {
    bestIndex = rIdx;
    firstNumber = int.parse(line[bestIndex]);
  }

  return firstNumber;
}

int findLastNumber(String line) {
  var bestIndex = 0;
  var firstNumber = 0;

  for (var s in numberStrings.keys) {
    var sIdx = line.lastIndexOf(s);
    if (sIdx != -1 && sIdx >= bestIndex) {
      bestIndex = sIdx;
      firstNumber = numberStrings[s]!;
    }
  }

  var rIdx = line.lastIndexOf(RegExp(r'[0-9]'));
  if (rIdx != -1 && rIdx >= bestIndex) {
    bestIndex = rIdx;
    firstNumber = int.parse(line[bestIndex]);
  }

  return firstNumber;
}

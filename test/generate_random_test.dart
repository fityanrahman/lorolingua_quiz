import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

void main() {
  int generateRandom() {
    var intValue = 0;
    for (int i = 0; i <= 1000; i++) {
      intValue = Random().nextInt(2);
      print(intValue);
    }
    // print(intValue);

    return intValue;
  }

  test('print random nomor', () {
    expect(0 | 1, generateRandom());
  });
}

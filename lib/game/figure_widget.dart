import 'package:flutter/material.dart';

Widget figure(String path, bool visible) {
  return SizedBox(
    width: 250,
    height: 250,
    child: Visibility(
      visible: visible,
      child: Image.asset(path),
    ),
  );
}

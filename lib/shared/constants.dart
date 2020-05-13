import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey,width: 0.5)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 0.5)
    ));
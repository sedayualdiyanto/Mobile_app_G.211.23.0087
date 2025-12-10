import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    required this.color, required String imageUrl,
  });

  final String id;
  final String title;
  final Color color;

  String? get imageUrl => null;
}
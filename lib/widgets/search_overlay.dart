import 'package:flutter/material.dart';

class SearchOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final Future<void> Function(String) onSearch;

  const SearchOverlay({
    super.key,
    required this.onClose,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search products...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        onSearch(value);
                        onClose();
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onClose,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

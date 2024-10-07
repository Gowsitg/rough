import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
 final Function(String) onSearch; 

  const Searchbar({super.key, required this.onSearch});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search...  ',
          prefixIcon: Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty? IconButton(onPressed: () {
            _searchController.clear();
            widget.onSearch('');

          }, icon: Icon(Icons.close)): null,
          contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
        ),
         onChanged: widget.onSearch,
      ),
    );
  }
}

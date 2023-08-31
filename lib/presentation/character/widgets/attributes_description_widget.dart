import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String title;
  final String description;

  const DescriptionWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: const TextStyle(
            fontFamily: "poppins",
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        SizedBox(
          width: 250,
          child: Text(
            description,
            style: const TextStyle(
              fontFamily: "poppins",
              fontWeight: FontWeight.w400,
              fontSize: 21,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}

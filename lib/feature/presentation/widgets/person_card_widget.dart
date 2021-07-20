import 'package:clean_arc_proj/commmon/app_colors.dart';
import 'package:clean_arc_proj/feature/domain/entities/person_entity.dart';
import 'package:clean_arc_proj/feature/presentation/widgets/person_cache_image_widget.dart.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;
  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            child: PersonCacheImage(
              imageUrl: person.image,
              width: 166,
              height: 166,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  person.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: person.status == 'Alive'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        '${person.status} - ${person.species}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Last known location',
                  style: TextStyle(
                    color: AppColors.greyColor,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  person.location.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Origin',
                  style: TextStyle(color: AppColors.greyColor),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  person.origin.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}

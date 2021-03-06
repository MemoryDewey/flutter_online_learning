import 'package:baas_study/widget/skeleton.dart';
import 'package:flutter/material.dart';

class CourseCardSkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: SkeletonDecoration(isDark: isDark),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 18,
                  child: Container(
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 14,
                      child: Container(
                        decoration: SkeletonDecoration(isDark: isDark),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: 14,
                        width: double.infinity,
                        child: Container(
                          decoration: SkeletonDecoration(isDark: isDark),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseMngCardSkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 12),
      margin: EdgeInsets.only(bottom: 16),
      decoration: SkeletonDecoration(isDark: isDark),
      height: 182,
    );
  }
}

class CourseSimpleSkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(decoration: SkeletonDecoration(isDark: isDark)),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  decoration: SkeletonDecoration(isDark: isDark),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        height: 18,
                        width: 60,
                        decoration: SkeletonDecoration(isDark: isDark)),
                    Container(
                        height: 12,
                        width: 40,
                        decoration: SkeletonDecoration(isDark: isDark))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

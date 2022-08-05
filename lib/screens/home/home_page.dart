import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/bloc/bloc_get_data/fetch_data_bloc.dart';
import 'package:travel_app/models/category.dart';
import 'package:travel_app/models/image.dart';
import 'package:travel_app/models/style_color.dart';
import 'package:travel_app/models/travel_icons_icons.dart';
import 'package:travel_app/widgets/place_info.dart';
import 'package:travel_app/screens/profile.dart';
import 'package:travel_app/screens/selector_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routeName = '/homepage';

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 80, 35, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(TravelIcons.menu),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(ProfilePage.routeName);
                      },
                      child: FutureBuilder(builder: (context, snapshot) {
                        dynamic img;
                        if (FirebaseAuth.instance.currentUser?.photoURL !=
                            null) {
                          img = FirebaseAuth.instance.currentUser?.photoURL;
                        } else {
                          img = 'assets/images/user_default.png';
                        }
                        return CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(img));
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'Where do\nyou want to go?',
                  style: GoogleFonts.poppins(
                      color: styleColor.judul,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12.sp,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: TextField(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageSelector(
                                      routedIndex: 1,
                                    )));
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          TravelIcons.search,
                          size: 15.sp,
                        ),
                        hintText: 'Find the place',
                        hintStyle:
                            GoogleFonts.poppins(color: styleColor.subjudul),
                        fillColor: const Color.fromRGBO(246, 247, 248, 1),
                        filled: true,
                        border: InputBorder.none,
                      )),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                categoryIcons.map<Widget>((CateogryIcons data) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: data.color,
                                    borderRadius: BorderRadius.circular(16)),
                                width: 40.sp,
                                height: 40.sp,
                                child: data.icon,
                              );
                            }).toList()),
                        SizedBox(
                          height: 10.sp,
                        ),
                        const ContentsWidget(
                          recom: false,
                        ),
                        const ContentsWidget(
                          recom: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ContentsWidget extends StatelessWidget {
  const ContentsWidget({
    Key? key,
    required this.recom,
  }) : super(key: key);

  final bool recom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              recom ? 'Popular' : 'Recomendation',
              style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  color: styleColor.judul,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
            Row(
              children: [
                Text(
                  'See all',
                  style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      color: styleColor.style,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp),
                ),
                Icon(
                  TravelIcons.arrow_right,
                  size: 10.sp,
                  color: styleColor.style,
                ),
              ],
            ),
          ],
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<FetchDataBloc, FetchDataState>(
              bloc: BlocProvider.of<FetchDataBloc>(context),
              builder: (context, state) {
                if (state.ref.isEmpty) {
                  return SizedBox(
                    width: 230.sp,
                    height: 170.sp,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Row(
                      children: state.ref.map<Widget>((data) {
                    if (data.place.tag.recom != recom) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlaceInfo(widget: data.place, ref: data.ref),
                            )),
                        child: FilterContent(
                          img: data.place.img,
                          judul: data.place.judul,
                          lokasi: data.place.lokasi,
                          star: data.place.star,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }).toList());
                }
              },
            ))
      ],
    );
  }
}

class FilterContent extends StatelessWidget {
  const FilterContent({
    Key? key,
    required this.img,
    required this.judul,
    required this.lokasi,
    required this.star,
  }) : super(key: key);
  final String img;
  final String judul;
  final String lokasi;
  final double star;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9, bottom: 9),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SizedBox(
          width: 230.sp,
          height: 170.sp,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Card(
                clipBehavior: Clip.antiAlias,
                borderOnForeground: false,
                elevation: 2,
                child: Stack(
                  children: [
                    LayoutBuilder(builder: (context, constraint) {
                      return SizedBox(
                        height: constraint.maxHeight,
                        width: constraint.maxWidth,
                        child: Image.network(
                          img,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: LayoutBuilder(builder: (context, constraint) {
                        return Container(
                          color: Colors.white,
                          width: constraint.maxWidth,
                          height: 50.sp,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      judul,
                                      style: GoogleFonts.poppins(
                                          fontStyle: FontStyle.normal,
                                          color: styleColor.judul,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          TravelIcons.map,
                                          color: styleColor.subjudul,
                                          size: 9.sp,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Text(
                                          lokasi,
                                          style: GoogleFonts.poppins(
                                              fontStyle: FontStyle.normal,
                                              color: styleColor.subjudul,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Star(
                                  star: star,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class Star extends StatelessWidget {
  Star({Key? key, this.star = 0}) : super(key: key);
  double star;
  @override
  Widget build(BuildContext context) {
    List tes = [];
    if (star % 1 <= 0.5) {
      star += 1;
      for (var i = 1; i < star; i++) {
        i != star.floor()
            ? tes.add(const Icon(
                TravelIcons.star,
                color: Color(0xffE76D81),
              ))
            : tes.add(const Icon(
                Icons.star_half,
                color: Color(0xffE76D81),
              ));
      }
    } else {
      for (var i = 0; i < star; i++) {
        tes.add(const Icon(
          TravelIcons.star,
          color: Color(0xffE76D81),
        ));
      }
    }
    return Stack(
      children: [
        Row(
          children: dummyStar.map<Widget>((e) {
            return Row(
              children: [
                Icon(
                  e.icon,
                  color: e.color,
                  size: 10.sp,
                ),
                const SizedBox(
                  width: 3,
                )
              ],
            );
          }).toList(),
        ),
        star == 0
            ? const Text('')
            : Row(
                children: tes.map<Widget>((e) {
                  return Row(
                    children: [
                      Icon(
                        e.icon,
                        color: e.color,
                        size: 10.sp,
                      ),
                      const SizedBox(
                        width: 3,
                      )
                    ],
                  );
                }).toList(),
              ),
      ],
    );
  }
}

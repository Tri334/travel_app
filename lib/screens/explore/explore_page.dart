import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/bloc/bloc_filter_data/filter_data_bloc.dart';
import 'package:travel_app/bloc/bloc_get_data/fetch_data_bloc.dart';
import 'package:travel_app/bloc/bloc_get_favorite/favorite_get_bloc.dart';
import 'package:travel_app/models/style_color.dart';
import 'package:travel_app/models/travel_icons_icons.dart';
import 'package:travel_app/widgets/place_info.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({
    Key? key,
  }) : super(key: key);
  static String routeName = '/explore';

  final TextEditingController _searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 229, 230, 231),
                      borderRadius: BorderRadius.circular(12)),
                  height: 40.sp,
                  width: 180.sp,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 8),
                      child: TextField(
                          controller: _searchText,
                          onSubmitted: (value) {
                            context
                                .read<FilterDataBloc>()
                                .add(EventFilterBy(value));
                            // _searchText.clear();
                            debugPrint(_searchText.text);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                TravelIcons.search,
                                color: styleColor.subjudul,
                                size: 15.sp,
                              ),
                              border: InputBorder.none,
                              hintText: 'Search here')),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Container(
                    height: 40.sp,
                    width: 40.sp,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 230, 231),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.settings,
                      size: 15.sp,
                      color: styleColor.judul,
                    ))
              ],
            ),
            Row(
              children: [
                Text(
                  'Sort by:',
                  style: GoogleFonts.poppins(
                      color: styleColor.judul,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp),
                ),
                SizedBox(
                  width: 2.sp,
                ),
                BlocBuilder<FilterDataBloc, FilterDataState>(
                  builder: (context, state) {
                    return DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 15.sp,
                      ),
                      iconEnabledColor: styleColor.style,
                      underline: Container(),
                      style: GoogleFonts.poppins(
                          color: styleColor.style,
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp),
                      value: state.filter,
                      items: <String>[
                        '-',
                        "Highest Price",
                        "Lowest Price",
                        "Place",
                        "Review"
                      ].map<DropdownMenuItem>((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (value) {
                        context
                            .read<FilterDataBloc>()
                            .add(EventFilterBy(value));
                      },
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<FilterDataBloc, FilterDataState>(
                  builder: (context, state) {
                    return Column(
                      children: state.dataFilter.map<Widget>((data) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: LayoutBuilder(builder: (context, constraint) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(data.place.img),
                                          fit: BoxFit.cover),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(0, 0.2),
                                            blurRadius: 4,
                                            color:
                                                Colors.black.withOpacity(0.1))
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  height: 200.sp,
                                  width: constraint.maxWidth,
                                ),
                                Positioned(
                                  top: 20,
                                  left: 10,
                                  right: 10,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                234, 235, 239, 0.6),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        width: 44.sp,
                                        height: 26.sp,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              TravelIcons.star,
                                              color: Colors.white,
                                              size: 13.sp,
                                            ),
                                            SizedBox(
                                              width: 2.sp,
                                            ),
                                            Text(
                                              data.place.star.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlaceInfo(
                                              widget: data.place,
                                              ref: data.ref),
                                        )),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      height: 55.sp,
                                      width: constraint.maxWidth,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.place.judul,
                                                  style: GoogleFonts.poppins(
                                                      color: styleColor.judul,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp),
                                                ),
                                                SizedBox(
                                                  height: 2.sp,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      TravelIcons.map,
                                                      size: 8.sp,
                                                      color:
                                                          styleColor.subjudul,
                                                    ),
                                                    SizedBox(
                                                      width: 2.sp,
                                                    ),
                                                    Text(
                                                      data.place.lokasi,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: styleColor
                                                                  .subjudul,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 11.sp),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Text(
                                              "\$${data.place.harga}",
                                              style: GoogleFonts.poppins(
                                                  color: styleColor.style,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13.sp),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

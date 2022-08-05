import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/bloc/bloc_get_data/fetch_data_bloc.dart';
import 'package:travel_app/bloc/bloc_get_favorite/favorite_get_bloc.dart';
import 'package:travel_app/models/add_dummy_data.dart';
import 'package:travel_app/models/database.dart';
import 'package:travel_app/models/style_color.dart';
import 'package:travel_app/models/travel_icons_icons.dart';
import 'package:travel_app/screens/home/home_page.dart';

class PlaceInfo extends StatelessWidget {
  const PlaceInfo({Key? key, required this.widget, required this.ref})
      : super(key: key);
  static String routeName = '/placeinfo';
  final Place widget;
  final String ref;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.img,
                fit: BoxFit.cover,
              )),
          Positioned(
            top: 40,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(234, 235, 239, 0.6),
                    child: Center(
                      child: Icon(
                        TravelIcons.arrow_left,
                        color: Colors.white,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      context
                          .read<FetchDataBloc>()
                          .add(EventFavorite(updateFavorite: ref));
                      Future.delayed(const Duration(seconds: 1)).then((value) =>
                          context
                              .read<FavoriteGetBloc>()
                              .add(EventGetFavorite()));
                    },
                    child: BlocBuilder<FetchDataBloc, FetchDataState>(
                      bloc: BlocProvider.of<FetchDataBloc>(context),
                      builder: (context, state) {
                        for (var element in state.ref) {
                          if (element.ref == ref) {
                            widget.favorite = element.place.favorite;
                          }
                        }
                        return CircleAvatar(
                          backgroundColor:
                              const Color.fromRGBO(234, 235, 239, 0.6),
                          child: Center(
                            child: Icon(
                              TravelIcons.favorite,
                              size: 15.sp,
                              color: widget.favorite
                                  ? styleColor.style
                                  : Colors.white,
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: CardContent(
              img: widget.img,
              agen: widget.agen,
              judul: widget.judul,
              lokasi: widget.lokasi,
              star: widget.star,
              dsc: widget.dsc,
              fasilitas: widget.fasilitas,
              harga: widget.harga,
            ),
          )
        ],
      ));
    });
  }
}

class CardContent extends StatelessWidget {
  const CardContent({
    Key? key,
    required this.judul,
    required this.lokasi,
    required this.star,
    required this.dsc,
    required this.fasilitas,
    required this.harga,
    required this.img,
    required this.agen,
  }) : super(key: key);
  final String img, agen, judul, lokasi, dsc;
  final double star, harga;
  final List<String> fasilitas;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.7,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                Row(
                  children: [
                    Star(
                      star: star,
                    ),
                    Text(
                      '($star)',
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
            SizedBox(
              height: 10.sp,
            ),
            ListingAgent(agen: agen, img: img),
            Expanded(
              // color: Colors.green,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              color: styleColor.judul,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp),
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Text(
                          dsc,
                          textAlign: TextAlign.justify,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              color: styleColor.subjudul,
                              fontWeight: FontWeight.w400,
                              fontSize: 9.sp),
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Facility',
                              style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  color: styleColor.judul,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              'See all',
                              style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  color: styleColor.style,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp),
                            )
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: fasilitas.map<Widget>((e) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 35.sp,
                                      height: 35.sp,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: styleColor.subjudul,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Icon(
                                        getTravelIcon(e),
                                        size: 12.sp,
                                      ),
                                    ),
                                    Text(
                                      e.length > 2
                                          ? e.replaceFirst(
                                              e[0], e[0].toUpperCase())
                                          : e.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                          fontStyle: FontStyle.normal,
                                          color: styleColor.judul,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.sp),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 2.sp,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            color: styleColor.subjudul,
                            fontWeight: FontWeight.w600,
                            fontSize: 9.sp),
                      ),
                      Text(
                        '\$$harga',
                        style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            color: styleColor.style,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: styleColor.style,
                          borderRadius: BorderRadius.circular(18)),
                      width: 120.sp,
                      height: 40.sp,
                      child: Center(
                        child: Text(
                          'Book Now',
                          style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.harga,
  }) : super(key: key);
  final double harga;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 5, bottom: 20),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: GoogleFonts.poppins(
                    fontStyle: FontStyle.normal,
                    color: styleColor.subjudul,
                    fontWeight: FontWeight.w600,
                    fontSize: 9.sp),
              ),
              Text(
                '\$$harga',
                style: GoogleFonts.poppins(
                    fontStyle: FontStyle.normal,
                    color: styleColor.style,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp),
              )
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: styleColor.style,
                  borderRadius: BorderRadius.circular(18)),
              width: 120.sp,
              height: 40.sp,
              child: Center(
                child: Text(
                  'Book Now',
                  style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListingAgent extends StatelessWidget {
  const ListingAgent({
    Key? key,
    required this.img,
    required this.agen,
  }) : super(key: key);
  final String img, agen;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listing Agent',
          style: GoogleFonts.poppins(
              fontStyle: FontStyle.normal,
              color: styleColor.judul,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(img),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agen,
                      style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          color: styleColor.judul,
                          fontWeight: FontWeight.w600,
                          fontSize: 9.sp),
                    ),
                    Text(
                      'Owner',
                      style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          color: styleColor.subjudul,
                          fontWeight: FontWeight.w600,
                          fontSize: 8.sp),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: const Color(0xffFA4560).withOpacity(0.12),
                    radius: 15.sp,
                    child: Icon(
                      color: styleColor.style,
                      TravelIcons.message,
                      size: 13.sp,
                    )),
                SizedBox(
                  width: 10.sp,
                ),
                CircleAvatar(
                    backgroundColor: const Color(0xffFA4560).withOpacity(0.12),
                    radius: 15.sp,
                    child: Icon(
                      color: styleColor.style,
                      TravelIcons.phone,
                      size: 13.sp,
                    ))
              ],
            )
          ],
        )
      ],
    );
  }
}
